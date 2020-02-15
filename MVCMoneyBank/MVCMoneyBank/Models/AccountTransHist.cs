using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MVCMoneyBank.Models
{
    public class AccountTransHist
    {
        [Display(Name = "ID")]
        public int CustomerID { get; set; }
        [Display(Name = "Date")]
        public DateTime? CreateDate { get; set; }
        [Display(Name = "Transaction Type")]
        public string TransactionName { get; set; }
        [Display(Name = "Amount")]
        public decimal? Amount { get; set; }
        [Display(Name = "Remaining Balance")]
        public decimal? RemainingBalance { get; set; }
    }
}