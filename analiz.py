from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client["CDC"]
collection = db["logs"]

print("- Analiz Sonuçları -\n")

print("1. Son 10 değişiklik:")
cursor = collection.find().sort("changed_at", -1).limit(10) # tarihe göre azalan sıra

for log in cursor:
    tarih = log.get('changed_at', 'Tarih yok')
    islem = log.get('operation')
    siparis_id = log.get('order_id')
    urun = log.get('product', 'Bilinmiyor')
    durum = log.get('status', 'Bilinmiyor')
    print(f"[{tarih}] {islem} -> Sipariş No: {siparis_id}, Ürün: {urun}, Durum: {durum}")

print("\n2. En çok değişiklik yapılan müşteri:")
pipeline_musteri = [
    {"$group": {"_id": "$customer_id", "toplam_islem": {"$sum": 1}}},
    {"$sort": {"toplam_islem": -1}}, 
    {"$limit": 1}
]
sonuc = list(collection.aggregate(pipeline_musteri))

if sonuc:
    en_aktif = sonuc[0]
    print(f"Müşteri ID: {en_aktif['_id']}")
    print(f"İşlem sayısı: {en_aktif['toplam_islem']}")
else:
    print("Veri bulunamadı.")

print("\n3. En çok güncellenen tablo:")
pipeline_tablo = [
    {"$group": {"_id": "$table", "toplam_islem": {"$sum": 1}}},
    {"$sort": {"toplam_islem": -1}}
]
sonuc_tablo = collection.aggregate(pipeline_tablo)

for tablo in sonuc_tablo:
    print(f"Tablo adı: {tablo['_id']} -> {tablo['toplam_islem']} işlem.")