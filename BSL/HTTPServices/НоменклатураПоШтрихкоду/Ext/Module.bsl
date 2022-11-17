﻿
Функция Productsget(Запрос)
	
	Штрихкод 		= Запрос.ПараметрыURL.Получить("code");
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.Заголовки.Вставить("content-Type","text/html;charset=utf-8");	
	ОстаткиДСJson 	= ПолучитьНоменклатуру(Штрихкод);
	Ответ.УстановитьТелоИзСтроки(ОстаткиДСJson,КодировкаТекста.UTF8); 
	Возврат Ответ;

КонецФункции

Функция ПолучитьНоменклатуру(Штрихкод) 

	Запрос=Новый Запрос;
	Запрос.Текст=
	"ВЫБРАТЬ
	|ШтрихкодыНоменклатуры.Номенклатура.Наименование КАК Наименование,  
	|ШтрихкодыНоменклатуры.Характеристика.Наименование как Характеристика,
	|ШтрихкодыНоменклатуры.Штрихкод КАК ШтриховойКод,
	|ШтрихкодыНоменклатуры.Номенклатура.Артикул КАК НоменклатураАртикул,
	|ТоварыНаСкладахОстатки.Склад.Наименование КАК Склад,
	|ТоварыНаСкладахОстатки.ВНаличииОстаток КАК остаток
	|ИЗ
	|	РегистрСведений.ШтрихкодыНоменклатуры КАК ШтрихкодыНоменклатуры
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыНаСкладах.Остатки(&НаДату, ) КАК ТоварыНаСкладахОстатки
	|		ПО (ШтрихкодыНоменклатуры.Номенклатура = ТоварыНаСкладахОстатки.Номенклатура)
	|ГДЕ
	|	ШтрихкодыНоменклатуры.Штрихкод = &Штрихкод";

	Запрос.УстановитьПараметр("НаДату",ТекущаяДата()); 
	Запрос.УстановитьПараметр("Штрихкод",Штрихкод);  
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	
	МойМассив = Новый Массив;    
	Пока выборка.СледующийПоЗначениюПоля("Наименование") Цикл          
		МояСтр = Новый Структура("ШтриховойКод,Наименование,Артикул,Остатки");

		ЗаполнитьЗначенияСвойств(МояСтр,Выборка); 
		МассивОстатков = Новый массив;
		Пока выборка.Следующий() Цикл
			МассивОстатков.Добавить(новый структура("Склад,Остаток",Выборка.Склад,Выборка.Остаток));
		КонецЦикла;
		МояСтр.Остатки = МассивОстатков;
		
		МойМассив.Добавить(МояСтр);
		
	КонецЦикла;
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	Попытка
		ЗаписатьJSON(ЗаписьJSON, МояСтр);
	Исключение
		ВызватьИсключение "" + ИнформацияОбОшибке() + ОписаниеОшибки();
	КонецПопытки;
	
	СтрокаJSON = ЗаписьJSON.Закрыть();
	Возврат СтрокаJSON;
	
 КонецФункции