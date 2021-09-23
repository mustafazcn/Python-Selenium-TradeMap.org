# PythonSelenium
Yaptığım uygulama ile Adana Sanayi Odasında hazırlanan ülke raporlarını pratik ve zaman kaybının önlenmesi amaçlanmıştır.
Uygulama sayesinde TradeMap.org daki ülkelerin ithalat ve ihracat verileri web scraping yöntemi ile Microsoft SQL Server a kaydedilmektedir.
Uygulama da Python un Requests ve Beautiful Soup kütüphaneleri kullanılmıştır. Bu kütüphaneler sayesinde web sayfaları da ki sayfa kaynak kodları çekilip istenilen veriler listelenmiştir.
Uygulama raporlaması ASP.Net-Mvc ile görsel hale getirilmiştir ve EntityFramework kütüphanesi kullanılmışktır. Bu kütüphane de gerekli SQL Stroed Procedures ve Views ler oluşturulup Mvc üzerinde gerekli sorgular ile görselleştirilmiştir.
Selenium Modülü ile istenilen verilerin sayfa adreslerine giden bir bot yazılım tasarlanmış ve gittiği sitenin sayfa kaynak kodu çekilmiştir.

Requests Modülü Nedir?
Python, standart modüllerinin yanında harici yüzlerce kullanışlı modül ile birlikte çok güçlü bir dil. Bu gücü veren harika modüller var bunlardan biri de Requests modülü. Bu modül ile web üzerindeki isteklerinizi yöneteceksiniz. Mesela bu modül ile API entpointlerine PUT, DELETE, POST gibi istekler atabilirsiniz. Ben bu method u web sayfalarının sayfa kaynaklarını çekmek için kullandım. 

Beautiful Soup Modülü Nedir ve Ne için kullanılır?
BeautifulSoup, HTML veya XML dosyalarını işlemek için oluşturulmuş güçlü ve hızlı bir kütüphanedir. Bu modül ile bir kaynak içerisindeki HTML kodlarını ayrıştırıp sadece istediğimiz alanları kesen programlar, daha popüler adıyla BOT yazabilirsiniz. Requests modelinde çektiğimiz sayfa kaynakları burada düzenlenir. Sayfa kaynakları arasında birçok etiket ve gereksiz yazılar vardır. Bu modül sayesinde gereksiz ve kod içermeyen, sadece istediğimiz alanları getiren bir kod yazarız. Bu yazdığımız kodu pythonda for döngüsüne atayarak o sayfada bulunan tüm satırlardaki istediğimiz verileri getirebilirz.


Selenium Nedir?
Selenium, web uygulamalarını test etmek için taşınabilir bir çerçevedir. Selenium, bir test komut dosyası dilini öğrenmeye gerek kalmadan işlevsel testleri yazmak için bir oynatma aracı sağlar. Bazı sayfalar güvenlik önlemleri kapsamında Requests modülü ile bize sayfanın içersin de ki verileri getirmez. Bu modül sayesinde sanki o sayfaya bir kullanıcı girmiş ve o sayfada sayfa kaynağını incelemiş gibi o sayfa kaynağını bize getirir. Bu modül ile şifreli sayfalara login olarak girebilen bot yazılabilir. Kullanıcın yapmak istediği komutları bir bot yazılımı ile yapması sağlanır.  

