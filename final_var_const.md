Great question! Di Dart (termasuk Flutter), `final` dan `var` **sama-sama digunakan untuk mendeklarasikan variabel**, tapi **cara kerja dan batasannya berbeda**. Berikut penjelasan singkat dan padat:

---

### 🔹 `var`:  
- Tipe data **bisa berubah**, tapi nilai bisa diubah juga.
- Tidak bersifat immutable (tidak tetap).
- Bisa di-*reassign* nilainya.

```dart
var name = "Triadi";  // Dart tahu ini String
name = "Andi";        // ✅ boleh, karena `var` tidak final
```

---

### 🔹 `final`:  
- Nilainya **hanya bisa di-set sekali** (immutable).
- Setelah diisi, tidak bisa diubah lagi.
- Tipe data tetap bisa berubah (kalau objek), tapi referensinya tidak bisa diganti.

```dart
final age = 30;
age = 40; // ❌ Error: final variable can't be reassigned
```

---

### 🔥 Tambahan: `const`  
Kalau kamu ingin variabel benar-benar **konstan dan ditentukan saat kompilasi**, gunakan `const`.

```dart
const pi = 3.14; // Harus diketahui di compile-time
```

---

### 📊 Perbandingan Cepat

| Keyword | Bisa diubah? | Tipe tetap? | Waktu penentuan |
|--------|--------------|-------------|-----------------|
| `var`  | ✅ ya         | ❓ ditentukan otomatis | runtime |
| `final`| ❌ tidak bisa | ✅ ya        | runtime |
| `const`| ❌ tidak bisa | ✅ ya        | **compile-time** |

---

### 🧠 Contoh Beda Praktis

```dart
final list = [1, 2, 3];
list.add(4);          // ✅ Boleh (karena isinya berubah)
list = [5, 6];        // ❌ Tidak boleh (reassign)

var city = "Jakarta";
city = "Bandung";     // ✅ Boleh

const name = "Flutter"; // ✅ Harus diketahui sejak awal
```

---

Kalau kamu sedang belajar struktur Flutter atau ingin tahu kapan paling cocok pakai `final`/`const` di widget, tinggal bilang aja!
