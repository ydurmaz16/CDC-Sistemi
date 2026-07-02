# Change Data Capture (CDC) Pipeline: MySQL to MongoDB

Bu proje, bir ilişkisel veritabanındaki (MySQL) değişiklikleri (INSERT, UPDATE, DELETE) gerçek zamanlıya yakın bir hızda yakalayarak NoSQL bir veritabanına (MongoDB) loglayan bir CDC sistemidir.

## Kullanılan Teknolojiler
* Python (Veri işleme ve senkronizasyon)
* MySQL (Kaynak veritabanı, Trigger'lar)
* MongoDB (Hedef log veritabanı)

## Sistem Mimarisi (Trigger + Polling)
* Kaynak veritabanındaki `Orders` tablosunda gerçekleşen işlemler, trigger'lar ile `Orders_Log` tablosuna kaydedilir.
* Python scripti, `Orders_Log` tablosunu belirli aralıklarla tarar.
* Henüz işlenmemiş (`is_processed = 0`) kayıtlar yakalanıp JSON formatında MongoDB'ye aktarılır.
* Başarılı aktarım sonrası MySQL'deki ilgili kaydın durumu güncellenir (`is_processed = 1`).
