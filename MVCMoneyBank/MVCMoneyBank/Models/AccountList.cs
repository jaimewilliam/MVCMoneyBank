using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MVCMoneyBank.Models
{
    public class AccountList
    {

        public int AccountId { get; set; }
        [Display(Name = "Account No")]
        public string AccountNo { get; set; }
        [Display(Name = "Customer ID")]
        public int CustomerID { get; set; }

        [Required]
        [Display(Name = "Customer Name")]
        public string CustomerName { get; set; }

        [Required]
        [Display(Name = "Mobile Number")]
        public string MobileNumber { get; set; }

        [Required]
        [Display(Name = "Initial Deposit")]
        public decimal? Amount { get; set; }

        public int? CustomerFK { get; set; }

        public List<AccountTransHist> AccountTransHist { get; set; }
        public List<MobileNumber> MobileNumbers { get; set; }

    }
}