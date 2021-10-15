using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ORMPrac2.model2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            using (model2.DB2EntityContainer db = new model2.DB2EntityContainer())
            {
                var oAgents = db.AGENTS.ToList();
                if (oAgents.Count > 0)
                {
                    MessageBox.Show("La base de datos ya contiene informacion ", "operacione Exitosa", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    // todo
                    //se llena la base de datos
                    using (var dbTransaction = db.Database.BeginTransaction())
                    {
                        try
                        {
                           List<model2.AGENTS> agentes = new List<model2.AGENTS>();


                           agentes.Add(new model2.AGENTS { AGENTS_CODE = 6, AGENT_NAME = "Ramasundar", WORKING_AREA = "Bangalore", COMISSION = 0.15m, COUNTRY = "", PHONE_NO = "077-25814763" });
                        
                           List<model2.>
                           db.AGENTS.AddRange(agentes);
                           db.SaveChanges();
                           dbTransaction.Commit();

                          MessageBox.Show("Database has been populated successfully", "Successful operation", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                         catch (Exception ex)
                        {

                        }
                        MessageBox.Show("La base de datos se lleno de pequeños daticos ", "operacione Exitosa", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                button1.Enabled = false;
            }
        }
    }
}
