
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------


namespace MVCMoneyBank.Models
{

using System;
    using System.Collections.Generic;
    
public partial class Account
{

    public int AccountId { get; set; }

    public string AccountNo { get; set; }

    public Nullable<int> CustomerFK { get; set; }

    public Nullable<System.DateTime> CreateDate { get; set; }

    public Nullable<System.DateTime> UpdateDate { get; set; }

}

}