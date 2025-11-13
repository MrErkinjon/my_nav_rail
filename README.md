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
| ![Mobil](https://raw.githubusercontent.com/MrErkinjon/my_nav_rail/main/image/mobile.png) | ![Planshet](https://raw.githubusercontent.com/MrErkinjon/my_nav_rail/main/image/tablet.png) | ![Kompyuter](https://raw.githubusercontent.com/MrErkinjon/my_nav_rail/main/image/desktop.png) |


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
    MIT License
    
    Copyright (c) 2025 Erkinjon
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
[LICENSE](https://github.com/MrErkinjon/my_nav_rail/blob/main/blob/main/LICENSE)