from bs4 import BeautifulSoup
from selenium import webdriver
import time
import pyodbc


driver_path = "C:\\Users\\ASUS\\Downloads\\webDriver\\chromedriver.exe"
browser = webdriver.Chrome(driver_path)

browser.get("https://www.trademap.org/Index.aspx?nvpm=1%7c%7c%7c%7c%7c%7c%7c%7c%7c%7c%7c%7c%7c%7c%7c%7c%7c")
time.sleep(3)

productComboBx = browser.find_element_by_css_selector("#ctl00_PageContent_RadComboBox_Product_Input")
productComboBx.click()
time.sleep(3)
c1 = browser.find_element_by_css_selector("#ctl00_PageContent_RadComboBox_Product_c0")
c1.click()
time.sleep(1)


productComboBx2 = browser.find_element_by_css_selector("#ctl00_PageContent_RadComboBox_Country_Input")
productComboBx2.click()
productComboBx2.send_keys("Turkey")
time.sleep(1)
c2 = browser.find_element_by_css_selector("#ctl00_PageContent_RadComboBox_Country_c0")
c2.click()
time.sleep(1)

AraBtn = browser.find_element_by_css_selector("#ctl00_PageContent_Button_TimeSeries")
AraBtn.click()
YilBtn = browser.find_element_by_css_selector("#ctl00_PageContent_GridViewPanelControl_DropDownList_PageSize")
YilBtn.click()
time.sleep(1)

YilSayisi = browser.find_element_by_css_selector("#ctl00_PageContent_GridViewPanelControl_DropDownList_PageSize > option:nth-child(5)")
YilSayisi.click()
time.sleep(1)

page1 = browser.page_source
time.sleep(1)


BeautifulSoup(page1 , "html.parser")
soup1 = BeautifulSoup(page1 , "html.parser")

li1 = soup1.find("table" , attrs={"id" : "ctl00_PageContent_MyGridView1"}).select("tr:nth-of-type(n+3)")

ulkeAd = []
for var in li1:
    ulkeAd.append(var.select("td:nth-of-type(2) > a")[0].text)

print(ulkeAd)


db = pyodbc.connect(
    'Driver={SQL Server};'
    'Server=.\SQLEXPRESS;'
    'Database=TradeMapDB;'
    'Trusted_Connection=True;'
)

imlec = db.cursor()
for i in range(0 , 221):
    komut = 'INSERT INTO UlkeListesi(ulkeAd) VALUES(?)'
    veriler = (ulkeAd[i])
    sonuc = imlec.execute(komut,veriler)
    db.commit()
imlec.execute('SELECT * FROM [UlkeListesi]')
Tablo1DB = imlec.fetchall()
for i in Tablo1DB:              ## VERİLERİ ÇAĞIRIR
    print(i)




