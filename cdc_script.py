import time
import mysql.connector
from pymongo import MongoClient

MYSQL_SIFRE = "12345Abc." 
DB_ADI = "projeTest" 

def cdc_baslat():
    # MySQL
    try:
        mysql_db = mysql.connector.connect(
            host="localhost",
            user="root",
            password=MYSQL_SIFRE,
            database=DB_ADI,
            autocommit=True
        )
        cursor = mysql_db.cursor(dictionary=True)  # sözlük şeklinde
        print(f"MySQL'e bağlandı: {DB_ADI}")
    except Exception as e:
        print(f"MySQL hatası: {e}")
        return

    # MongoDB
    try:
        mongo_client = MongoClient("mongodb://localhost:27017/")
        mongo_db = mongo_client["CDC"] 
        mongo_collection = mongo_db["logs"] 
        print("MongoDB'ye bağlandı.")
    except Exception as e:
        print(f"MongoDB hatası: {e}")
        return

    print("\n- Dinleme moduna geçildi (Çıkış için Ctrl+C) -\n")

    while True:
        try:
            # polling
            cursor.execute("SELECT * FROM Orders_Log WHERE is_processed = 0")
            changes = cursor.fetchall()

            if changes:
                print(f"Değişiklik sayısı: {len(changes)}")
                
                for change in changes:
                    mongo_doc = {
                        "operation": change['operation_type'],
                        "table": "Orders",
                        "order_id": change['order_id'],
                        "customer_id": change['customer_id'],
                        "product": change['product'],
                        "amount": float(change['amount']), 
                        "status": change['status'],
                        "changed_at": change['change_date']
                    }

                    mongo_collection.insert_one(mongo_doc)
                    print(f"MongoDB'ye aktarıldı: Sipariş ID {change['order_id']} ({change['operation_type']})")

                    update_query = "UPDATE Orders_Log SET is_processed = 1 WHERE log_id = %s" # aynı veriyi tekrar almasın diye
                    cursor.execute(update_query, (change['log_id'],))
                    mysql_db.commit()

            else:
                pass

            time.sleep(2) # sistemi dinlendirmek için

        except KeyboardInterrupt:
            print("\nCDC Servisi durduruldu.")
            break
        except Exception as e:
            print(f"Hata oluştu: {e}")
            time.sleep(5)

if __name__ == "__main__":
    cdc_baslat()