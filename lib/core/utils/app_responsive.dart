//فى الكلاس ده بخلى الشاشه ريسبونسف تتماشى مع اى اسكرين مهما كان حجمها مع اى شاشه
//بنستعمل حاجه اسمها ميديا كوريرى
//بجيب العرض والارتفاع للشاشه كاملة 

import 'package:flutter/material.dart';

class AppResponsive {

static double width (BuildContext context/**علشان يقرى اتجاهات الاسكرين */) =>MediaQuery.of(context/* علشان اشاور على الاسكرين الى واقف عليها */  ).size.width;
static double heigth (BuildContext context) =>MediaQuery.of(context ).size.height;



}
