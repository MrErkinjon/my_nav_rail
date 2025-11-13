# 🧭 My Nav Rail

**My Nav Rail** — bu Flutter uchun **adaptiv Navigation Rail** vidjeti bo‘lib, u mobil, planshet va kompyuter ekranlariga moslashadi.  
Minimal kod bilan **to‘liq responsiv navigatsiya tizimi** yarating.

---

## ✨ Asosiy xususiyatlar

- 📱 Mobil, 💻 Planshet va 🖥️ Kompyuter uchun adaptiv dizayn
- 🎨 Material 3 dizayn tamoyillariga mos
- ⚙️ To‘liq sozlanadigan (`customizable`) ranglar, ikonlar va animatsiyalar
- 🔄 Oddiy API: `MyNavRail` va `MyNavDestination` bilan ishlash oson

---
## 🖼️ Interfeyslar

|                                Mobil                                 |                                     Planshet                                      |                                 Kompyuter                                 |
|:--------------------------------------------------------------------:|:---------------------------------------------------------------------------------:|:-------------------------------------------------------------------------:|
| ![Mobil](https://github.com/MrErkinjon/my_nav_rail/blob/main/image/mobile.png) | ![Planshet](https://github.com/MrErkinjon/my_nav_rail/blob/main/image/tablet.png) | ![Kompyuter](https://github.com/MrErkinjon/my_nav_rail/blob/main/image/desktop.png) |


## 🚀 O‘rnatish

`pubspec.yaml` faylingizga quyidagini qo‘shing:

```yaml
dependencies:
  my_nav_rail: ^0.0.1
  
```

## so‘ng terminalda bajaring:
```
flutter pub get
```
## 🧩 Foydalanish

```dart

import 'package:flutter/material.dart';
import 'package:my_nav_rail/my_nav_rail.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          MyNavRail(
            selectedIndex: 0,
            destinations: const [
              MyNavDestination(icon: Icons.home, label: 'Bosh sahifa'),
              MyNavDestination(icon: Icons.favorite, label: 'Sevimlilar'),
              MyNavDestination(icon: Icons.settings, label: 'Sozlamalar'),
            ],
            onDestinationSelected: (index) {
              debugPrint('Tanlangan: $index');
            },
          ),
          const Expanded(
            child: Center(
              child: Text('Tanlangan sahifa kontenti'),
            ),
          ),
        ],
      ),
    );
  }
}


```

## ⚙️ Muhit talablari

    Dart SDK: >=3.0.0
    
    Flutter SDK: >=3.3.0

## 🧑‍💻 Muallif

    👤 Erkinjon
    📦 my_nav_rail paket muallifi
    🔗 GitHub: @MrErkinjon

## 🪪 Litsenziya
    Ushbu loyiha MIT License asosida tarqatiladi.
    Batafsil ma’lumot: 
[LICENSE](https://github.com/MrErkinjon/my_nav_rail/blob/main/LICENSE)