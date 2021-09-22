from bs4 import BeautifulSoup
from selenium import webdriver
import time
import pyodbc
import tkinter as tk
from tkinter import messagebox


def secimAl():
    ulkeisim = tx_ulkeisim.get()
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
    productComboBx2.send_keys(ulkeisim)
    time.sleep(1)
    c2 = browser.find_element_by_css_selector("#ctl00_PageContent_RadComboBox_Country_c0")
    c2.click()
    time.sleep(1)

    AraBtn = browser.find_element_by_css_selector("#ctl00_PageContent_Button_TimeSeries")
    AraBtn.click()
    YilBtn = browser.find_element_by_css_selector("#ctl00_PageContent_GridViewPanelControl_DropDownList_NumTimePeriod")
    YilBtn.click()
    time.sleep(1)

    YilSayisi = browser.find_element_by_css_selector(
        "#ctl00_PageContent_GridViewPanelControl_DropDownList_NumTimePeriod > option:nth-child(5)")
    YilSayisi.click()
    time.sleep(1)

    page1 = browser.page_source
    time.sleep(1)

    ihracat = browser.find_element_by_css_selector("#ctl00_NavigationControl_DropDownList_TradeType")
    ihracat.click()
    time.sleep(1)
    ihracatbtn = browser.find_element_by_css_selector(
        "#ctl00_NavigationControl_DropDownList_TradeType > option:nth-child(1)")
    ihracatbtn.click()
    time.sleep(5)
    page2 = browser.page_source

    BeautifulSoup(page1, "html.parser")
    BeautifulSoup(page2, "html.parser")

    soup1 = BeautifulSoup(page1, "html.parser")
    soup2 = BeautifulSoup(page2, "html.parser")

    li1 = soup1.find("table", attrs={"id": "ctl00_PageContent_MyGridView1"}).select(
        "tr:nth-of-type(2) > th:nth-of-type(n+3)")

    li2 = soup1.find("table", attrs={"id": "ctl00_PageContent_MyGridView1"}).select(
        "tr:nth-of-type(n+4) > td:nth-of-type(n+3)")
    li3 = soup2.find("table", attrs={"id": "ctl00_PageContent_MyGridView1"}).select(
        "tr:nth-of-type(n+4) > td:nth-of-type(n+3)")
    li4 = soup1.find("table", attrs={"id": "ctl00_PageContent_MyGridView1"}).select("tr:nth-of-type(n+4)")
    li5 = soup2.find("table", attrs={"id": "ctl00_PageContent_MyGridView1"}).select("tr:nth-of-type(n+4)")

    li6 = soup1.find("table", attrs={"id": "ctl00_PageContent_MyGridView1"}).select(
        "tr:nth-of-type(3) > td:nth-of-type(n+3)")
    li7 = soup2.find("table", attrs={"id": "ctl00_PageContent_MyGridView1"}).select(
        "tr:nth-of-type(3) > td:nth-of-type(n+3)")

    ulkeAd = []
    Yil = []
    ithalat_ulkeAd = []
    ithalat = []
    ihracat_ulkeAd = []
    ihracat = []

    top_ithalat = []
    top_ihracat = []

    for date in li1:
        Yil1 = date.a.text
        Yil2 = Yil1[-4:]

        Yil.append(Yil2)

    YeniYil = Yil * 24

    for imports in li2:
        it1 = imports.text
        if it1 == "3":
            continue
        else:
            s1 = int(it1.replace(",", ""))
            ithalat.append(s1)

    for exports in li3:
        ih1 = exports.text
        if ih1 == "3":
            continue
        else:
            s2 = int(ih1.replace(",", ""))
            ihracat.append(s2)

    for importscountry in li4:
        ulkeAdlari = importscountry.select("td:nth-of-type(2) > a")[0].text
        if ulkeAdlari == "2":
            continue
        else:

            ithalat_ulkeAd.append(ulkeAdlari)
            ithalat_ulkeAd.append(ulkeAdlari)
            ithalat_ulkeAd.append(ulkeAdlari)
            ithalat_ulkeAd.append(ulkeAdlari)
            ithalat_ulkeAd.append(ulkeAdlari)
            ithalat_ulkeAd.append(ulkeAdlari)
            ithalat_ulkeAd.append(ulkeAdlari)
            ithalat_ulkeAd.append(ulkeAdlari)
            ithalat_ulkeAd.append(ulkeAdlari)
            ithalat_ulkeAd.append(ulkeAdlari)

    for exportscountry in li5:
        ulkeAdlari = exportscountry.select("td:nth-of-type(2) > a")[0].text
        if ulkeAdlari == "2":
            continue
        else:

            ihracat_ulkeAd.append(ulkeAdlari)
            ihracat_ulkeAd.append(ulkeAdlari)
            ihracat_ulkeAd.append(ulkeAdlari)
            ihracat_ulkeAd.append(ulkeAdlari)
            ihracat_ulkeAd.append(ulkeAdlari)
            ihracat_ulkeAd.append(ulkeAdlari)
            ihracat_ulkeAd.append(ulkeAdlari)
            ihracat_ulkeAd.append(ulkeAdlari)
            ihracat_ulkeAd.append(ulkeAdlari)
            ihracat_ulkeAd.append(ulkeAdlari)

    for topimports in li6:
        it1 = topimports.text
        if it1 == "3":
            continue
        else:
            s1 = int(it1.replace(",", ""))
            top_ithalat.append(s1)

    for topexports in li7:
        ih1 = topexports.text
        if ih1 == "3":
            continue
        else:
            s2 = int(ih1.replace(",", ""))
            top_ihracat.append(s2)

    a = 1
    while a < 11:
        a += 1
        ulkeAd.append(ulkeisim)
    YeniulkeAd = ulkeAd * 24

    c = 0
    Hacim = []
    Denge = []
    while c <= 9:
        Hacim1 = top_ithalat[c] - top_ihracat[c]
        Hacim.append(Hacim1)
        Denge1 = top_ihracat[c] - top_ithalat[c]
        Denge.append(Denge1)

        c += 1


    db = pyodbc.connect(
        'Driver={SQL Server};'
        'Server=.\SQLEXPRESS;'
        'Database=TradeMapDB;'
        'Trusted_Connection=True;'
    )


    imlec = db.cursor()
    imlec.execute('SELECT * FROM [Ozel_Ulke_Raporu]')
    Tablo2DB = imlec.fetchall()
    for i in Tablo2DB:  ## VERİLERİ ÇAĞIRIR
        print(i)

    for i in range(0, 10):
        komut = 'Exec Proc_OzelUlkeRapor_Islem ? , ? , ? , ? , ? , ? , ? '
        veriler = ("Yeni", ulkeAd[i], Yil[i], top_ithalat[i], top_ihracat[i], Hacim[i], Denge[i])
        sonuc = imlec.execute(komut, veriler)
        db.commit()



    imlec.execute('SELECT * FROM [Genel_Ulke_Raporu]')
    Tablo3DB = imlec.fetchall()
    for i in Tablo3DB:  ## VERİLERİ ÇAĞIRIR
        print(i)
    i = 0
    for i in range(0, 240):
        komut = 'Exec Proc_GenelUlkeRapor_Islem ?,?,?,?,?,?,?'
        veriler = ("Yeni", YeniulkeAd[i], YeniYil[i], ithalat_ulkeAd[i], ithalat[i], ihracat_ulkeAd[i], ihracat[i])
        sonuc = imlec.execute(komut, veriler)
        db.commit()

    messagebox.showinfo("BİLGİ", "Verileriniz SQL kütüphanesine eklendi....")






pencere = tk.Tk()
pencere.geometry("400x200")
pencere.title("ADANA SANAYİ ODASI")
pencere.configure(bg ="Rosy Brown")


etiket = tk.Label(text = "Trade Map Data Extraction",bg="Indian Red")
etiket['font'] = "Verdal 12 bold"
etiket['fg'] = "#ffffff"
etiket.grid(row = 0 , column=0)
etiket.pack()


tx_ulkeisim = tk.Entry(width=20)
tx_ulkeisim.place(x = 130 , y = 75)


button = tk.Button(text = "Yearly Time Series" , command = secimAl , bg="Indian Red")
button.place(x = 112 , y =150)
button['font'] = "Verdal 12 bold"
button['fg'] = "#ffffff"


pencere.mainloop()

