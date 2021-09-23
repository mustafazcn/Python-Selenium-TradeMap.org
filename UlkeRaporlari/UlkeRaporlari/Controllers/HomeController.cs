using EntityFrameworkLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace UlkeRaporlari.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            PageItem item = new PageItem();
            using (TradeMapDBEntities db = new TradeMapDBEntities())
            {
                item.lstTablo1 = db.Proc_OzelUlkeRapor_Islem("Liste", "", "", 0, 0, 0, 0).ToList();
                item.lstTablo2 = db.Proc_GenelUlkeRapor_Islem("Liste", "", "", "", 0, "", 0).ToList();
            }

                return View(item);
        }

        public ActionResult About()
        {
            PageItem item = new PageItem();
            using (TradeMapDBEntities db = new TradeMapDBEntities())
            {
                item.lstTablo1 = db.Proc_OzelUlkeRapor_Islem("Liste", "", "", 0, 0, 0, 0).ToList();
                item.lstTablo2 = db.Proc_GenelUlkeRapor_Islem("Liste", "", "", "", 0, "", 0).ToList();
               

            }

            return View(item);
        }

      
        public ActionResult Contact()
        {
            PageItem item = new PageItem();
            using (TradeMapDBEntities db = new TradeMapDBEntities())
            {
                item.lstTablo1 = db.Proc_OzelUlkeRapor_Islem("Liste", "", "", 0, 0, 0, 0).ToList();
                item.lstTablo2 = db.Proc_GenelUlkeRapor_Islem("Liste", "", "", "", 0, "", 0).ToList();
            }

            return View(item);
        }
    }
    public class PageItem
    {
        public List<Proc_OzelUlkeRapor_Islem_Result> lstTablo1 = new List<Proc_OzelUlkeRapor_Islem_Result>();
        public List<Proc_GenelUlkeRapor_Islem_Result> lstTablo2 = new List<Proc_GenelUlkeRapor_Islem_Result>();
    }
}