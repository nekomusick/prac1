//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace otravez.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class ORDERS
    {
        public int ORD_NUM { get; set; }
        public decimal ORD_AMOUNT { get; set; }
        public decimal ADVANCE_AMOUNT { get; set; }
        public System.DateTime ORD_DATE { get; set; }
        public string ORD_DESCRIPTION { get; set; }
        public int AGENT_CODE { get; set; }
        public int CUST_CODE { get; set; }
    
        public virtual AGENTS AGENTS { get; set; }
        public virtual CUSTOMER CUSTOMER { get; set; }
    }
}
