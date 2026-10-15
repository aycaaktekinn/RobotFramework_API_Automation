# Robot Framework API Automation - User Guide

## Projenin Amacı

Bu proje, Robot Framework ve `RequestsLibrary` kullanılarak Swagger Petstore üzerinde API test otomasyonu geliştirmek amacıyla hazırlanmıştır.
(UI testleri ayrı `RobotFramework_UI_Automation` projesinde bulunur.)

Ortak işlemler resource dosyasına taşınmış ve custom keyword'ler oluşturulmuştur.

---

## Kullanılan Teknolojiler

- Python 3.13
- Robot Framework 7.4.2
- RequestsLibrary
- Swagger Petstore API

---

## Proje Yapısı

```text
RobotFramework_API_Automation/
├── resources/
│   └── api_keywords.robot
├── tests/
│   ├── create_pet.robot
│   ├── get_pet.robot
│   ├── update_pet.robot
│   └── delete_pet.robot
├── results/
├── venv/
├── requirements.txt
└── USER_GUIDE.md
```

---

## Kurulum

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

## API Testleri

CRUD işlemleri ayrı dosyalara bölünmüştür:

- `create_pet.robot` → POST
- `get_pet.robot` → GET
- `update_pet.robot` → PUT
- `delete_pet.robot` → DELETE

Ortak API işlemleri `resources/api_keywords.robot` içerisinde tutulmaktadır:

```robot
Create Petstore Session
Generate Pet Id
Create Pet Body
```

### POST - Create Pet

```text
POST /pet
```

Status code 200, ID, Name ve Status değerleri doğrulanır.

### GET - Get Pet

```text
GET /pet/{id}
```

Testin başka teste bağımlı olmaması için GET işleminden önce gerekli pet test içerisinde oluşturulur.

### PUT - Update Pet

Pet oluşturulduktan sonra status değeri `available → sold` olarak güncellenir ve response doğrulanır.

### DELETE - Delete Pet

Pet silindikten sonra aynı ID için tekrar GET isteği gönderilir. Beklenen sonuç `404 Not Found` olduğu için:

```robot
expected_status=404
```

kullanılmıştır.

---

## Test Bağımsızlığı

Her test kendi test datasını oluşturur; testler tek başına veya farklı sıralarda çalıştırılabilir.

---

## Testlerin Çalıştırılması

Tüm API testleri:

```bash
robot --outputdir results tests
```

Tek dosya:

```bash
robot --outputdir results tests/get_pet.robot
```

---

## Raporlama

Koşum sonunda `results` klasöründe oluşur:

- `report.html` → Genel PASS/FAIL özeti
- `log.html` → Test adımlarının ve keyword'lerin detaylı kaydı
- `output.xml` → Ham test sonucu

---

## Bu Projede Öğrenilenler

- Robot Framework
- Keyword-driven testing
- RequestsLibrary
- API CRUD testleri
- Assertion
- Custom keyword ve Resource kullanımı
- Test bağımsızlığı
- Robot Framework HTML raporlama
