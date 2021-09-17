using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Foroprac1
{
    public partial class Form1 : Form
    {
        public SqlConnection con = new SqlConnection(@"Data Source=(localdb)\MSSQLLocalDB;Integrated Security = SSPI; Initial Catalog = DBPrac1");
        SqlCommand cmd;
        SqlDataReader dr;
        
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            con.Open();
            MessageBox.Show("Conexion Creada Con Exito!");
            con.Close();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            con.Open();
            string query = "Select * from Alumno";
            cmd = new SqlCommand(query, con);

            SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();

            dataAdapter.Fill(ds);

            dataGridView1.ReadOnly = true;

            dataGridView1.DataSource = ds.Tables[0];


            con.Close();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
