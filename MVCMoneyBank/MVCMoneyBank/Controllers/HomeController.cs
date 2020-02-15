using MVCMoneyBank.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MVCMoneyBank.Controllers
{
    public class HomeController : Controller
    {
        BankEntities db = new BankEntities();
        
        public ActionResult List()
        {
            var list = from c in db.Customers
                       join a in db.Accounts on c.CustomerID equals a.CustomerFK
                       join m in db.MobileNumbers on c.CustomerID equals m.CustomerFK
                       select new AccountList { AccountId = a.AccountId, AccountNo = a.AccountNo, CustomerName = c.CustomerName, MobileNumber = m.MobileNumber1, CustomerFK = m.CustomerFK };

            //***How to get first record in each group using Linq
            IEnumerable<AccountList> list2 = from l in list
                                        group l by l.CustomerFK
                                        into groups
                                        select groups.OrderBy(p => p.CustomerFK).FirstOrDefault();
            return View(list2);

            
        }

        public ActionResult Details(int acctId)
        {
            var acctDetails = db.Accounts.Where(a => a.AccountId == acctId).FirstOrDefault();
            AccountList alist = new AccountList();
            alist.AccountId = acctId;
            alist.AccountNo = acctDetails.AccountNo;
            alist.CustomerID = db.Customers.Where(c => c.CustomerID == acctDetails.CustomerFK).Select(c => c.CustomerID).FirstOrDefault();
            alist.CustomerName = db.Customers.Where(c => c.CustomerID == acctDetails.CustomerFK).Select(c => c.CustomerName).FirstOrDefault();

            IEnumerable<AccountTransHist> transHist = from a in db.Accounts
                            join c in db.Customers on a.CustomerFK equals c.CustomerID
                            join t in db.Transactions on c.CustomerID equals t.CustomerFK
                            join tt in db.TransactionTypes on t.TransactionTypeFK equals tt.TransactionTypeID
                            where a.AccountId == acctId
                            select new AccountTransHist { CreateDate = t.CreateDate, TransactionName = tt.TransactionName, Amount = t.Amount, RemainingBalance = t.RemainingBalance };
            alist.AccountTransHist = transHist.ToList();
            return View(alist);
        }

        //public ActionResult TransHist()
        //{
        //    var transHist = from c in db.Customers
        //                  join a in db.Accounts on c.CustomerID equals a.CustomerFK
        //                  join t in db.Transactions on c.CustomerID equals t.CustomerFK
        //                  join tt in db.TransactionTypes on t.TransactionTypeFK equals tt.TransactionTypeID
        //                  select new AccountTransHist { CreateDate = t.CreateDate, TransactionName = tt.TransactionName, Amount = t.Amount, RemainingBalance = t.RemainingBalance };
        //    return View(transHist);
        //}

        public ActionResult Edit(int acctid)
        {
            AccountList acctlist = new AccountList();
            var acct = db.Accounts.Where(a => a.AccountId == acctid).FirstOrDefault();
            
            if (acct != null)
            {
                //**Get customer name
                var name = db.Customers.Where(c => c.CustomerID == acct.CustomerFK).Select(c => c.CustomerName).FirstOrDefault();
                var custid = db.Customers.Where(i => i.CustomerID == acct.CustomerFK).FirstOrDefault();
                //**Get Mobile Number
                var mbl = db.Customers.Where(c => c.CustomerID == acct.CustomerFK).FirstOrDefault();

                acctlist = new AccountList();
                acctlist.AccountId = acctid;
                acctlist.AccountNo = acct.AccountNo;
                acctlist.CustomerName = name;
                //acctlist.MobileNumber = db.MobileNumbers.Where(m => m.CustomerFK == mbl.CustomerID).Select(m => m.MobileNumber1).FirstOrDefault();

                var embl = db.MobileNumbers.Where(n => n.CustomerFK == custid.CustomerID).ToList();
                acctlist.MobileNumbers = embl.ToList();
                
            };

            return View(acctlist);
        }

        [HttpPost] //***EDIT|SAVE!
        public ActionResult Edit(AccountList accountList, string additionalnumbers)
        {
           // var acct = new Account();
            if (accountList != null)
            {
                if (accountList.AccountId == 0)
                {
                    var acctno = (0 + db.Accounts.Count()).ToString().PadLeft(10, '0');

                    var Customer = new Customer
                    {
                        CustomerName = accountList.CustomerName,
                        CreateDate = DateTime.Now,
                    };
                    db.Customers.Add(Customer);
                    db.SaveChanges();

                    var Account = new Account
                    {
                        AccountNo = acctno,
                        CustomerFK = Customer.CustomerID,
                        CreateDate = DateTime.Now,
                    };
                    db.Accounts.Add(Account);
                    db.SaveChanges();

                    if (!string.IsNullOrEmpty(additionalnumbers))
                    {
                        string[] mobilenumbers = additionalnumbers.Split(',');

                        for (int i = 0; i < mobilenumbers.Count(); i++)
                        {
                            var Mobile = new MobileNumber
                            {
                                MobileNumber1 = mobilenumbers[i],
                                CustomerFK = Customer.CustomerID,
                                CreateDate = DateTime.Now,
                            };
                            db.MobileNumbers.Add(Mobile);
                            db.SaveChanges();
                        }
                    }

                    var Deposit = new Transaction
                    {
                        Amount = accountList.Amount,
                        TransactionTypeFK = 1,
                        CustomerFK = Customer.CustomerID,
                        RemainingBalance = accountList.Amount,
                        CreateDate = DateTime.Now,
                        UpdateDate = DateTime.Now,
                    };
                    db.Transactions.Add(Deposit);
                    db.SaveChanges();

                }else
                {
                    var acct = db.Accounts.Where(a => a.AccountId == accountList.AccountId).FirstOrDefault();
                    
                    var name = db.Customers.Where(c => c.CustomerID == acct.CustomerFK).FirstOrDefault();
                    if (name != null)
                    {
                        
                        name.CustomerName = accountList.CustomerName;
                        name.UpdateDate = DateTime.Now;
                        db.SaveChanges();
                    }

                    if (accountList.MobileNumbers != null)
                    {
                        foreach (var item in accountList.MobileNumbers)
                        {
                            var num = db.MobileNumbers.Where(m => m.MobileNumberID == item.MobileNumberID).FirstOrDefault();
                            if (num != null)
                            {
                                num.MobileNumber1 = item.MobileNumber1;
                                num.UpdateDate = DateTime.Now;
                                db.SaveChanges();

                            }
                        }
                    }


                    //if (!string.IsNullOrEmpty(additionalnumbers))
                    //{
                    //    string[] mobilenumbers = additionalnumbers.Split(',');

                    //    for (int i = 0; i < mobilenumbers.Count(); i++)
                    //    {
                    //        int mobilenumber = accountList.MobileNumbers[i].MobileNumberID;
                    //        var num = db.MobileNumbers.Where(m => m.MobileNumberID == mobilenumber).FirstOrDefault();
                    //        if (num != null)
                    //        {
                    //            num.MobileNumber1 = mobilenumbers[i];
                    //            num.UpdateDate = DateTime.Now;
                    //            db.SaveChanges();

                    //        }
                    //    }
                    //}

                    if (!string.IsNullOrEmpty(additionalnumbers))
                    {
                        string[] mobilenumbers = additionalnumbers.Split(',');

                        for (int i = 0; i < mobilenumbers.Count(); i++)
                        {
                            var Mobile = new MobileNumber
                            {
                                MobileNumber1 = mobilenumbers[i],
                                CustomerFK = name.CustomerID,
                                CreateDate = DateTime.Now,
                            };
                            db.MobileNumbers.Add(Mobile);
                            db.SaveChanges();
                        }
                    }


                }
            }
            return View();
        }

        public ActionResult Teller(int custid)
        {
            //***Pass data/value in View using <element>
            //ViewBag.custid = custid;

            var transtype = db.TransactionTypes.ToList();    

            //***temporary pass data/value
            TempData["CustId"] = custid;
            TempData.Keep();

            return View(transtype);
        }

        [HttpPost]
        public ActionResult Teller(int transactionType, decimal? amount)
        {
            
            int custId = Convert.ToInt32(TempData["CustId"]);

            //get last remaining bal
            var oldval = db.Transactions.Where(o => o.CustomerFK == custId).OrderByDescending(r => r.CreateDate).FirstOrDefault().RemainingBalance;
            //add or minus amount based on transtype
            //decimal? newval = 0;
            //if (transactionType == 1)
            //{
            //    newval = oldval + amount;
            //}
            //else
            //{
            //    newval = oldval - amount;
            //}

            decimal? newval = transactionType == 1 ? oldval + amount : oldval - amount;

            if ((amount > 0 || amount !=null))
            {
                if(transactionType == 1 || (transactionType == 2 && amount <= oldval))
                {
                    var transaction = new Transaction
                    {
                        Amount = amount,
                        TransactionTypeFK = transactionType,
                        CustomerFK = custId,
                        RemainingBalance = newval,
                        CreateDate = DateTime.Now,
                        UpdateDate = DateTime.Now,
                    };
                    db.Transactions.Add(transaction);
                    db.SaveChanges();
                }
            }
            
            return RedirectToAction("Details", new { acctId = custId });
        }

        public ActionResult Delete(int acctId)
        {
            var acct = db.Accounts.Where(a => a.AccountId == acctId).FirstOrDefault();
            var cust = db.Customers.Where(c => c.CustomerID == acct.CustomerFK).FirstOrDefault();
            var mobl = db.MobileNumbers.Where(m => m.CustomerFK == cust.CustomerID).FirstOrDefault();
            var trns = db.Transactions.Where(t => t.CustomerFK == cust.CustomerID).FirstOrDefault();

            if (acct != null) { db.Accounts.Remove(acct); }
            if (cust != null) { db.Customers.Remove(cust); }
            if (mobl != null) { db.MobileNumbers.Remove(mobl); }
            if (trns != null) { db.Transactions.Remove(trns); }
            db.SaveChanges();

            return RedirectToAction("List");
        }
    }
}