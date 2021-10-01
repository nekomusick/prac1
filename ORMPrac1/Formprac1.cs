﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ORMPrac1
{
    public partial class Form1 : Form
    {
        public List<Model.ALUMNO>oAlumno;
        public List<Model.APODERADO>oApoderado;
        public List<Model.CURSO>oCurso;
        public List<Model.INSCRITO>oInscrito;
        int indice = 0;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //se llena el combobox
            comboBox1.Items.Add("ALUMNO");
            comboBox1.Items.Add("APODERADO");
            comboBox1.Items.Add("CURSO");
            comboBox1.Items.Add("INSCRITO");
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (Model.DBprac1Entities db = new Model.DBprac1Entities())
            {
                switch (comboBox1.SelectedIndex)
                {
                    case 0:
                        oAlumno = db.ALUMNO.ToList();
                        break;
                    case 1:
                        oApoderado = db.APODERADO.ToList();
                        break;
                    case 2:
                        oCurso = db.CURSO.ToList();
                        break;
                    case 3:
                        oInscrito = db.INSCRITO.ToList();
                        break;
                }
   
        }
            indice = 0;
            Llenar();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            indice--;
            Llenar();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            indice++;
            Llenar();
        }
        public void Llenar()
        {
            if (indice < 0)
                indice = 0;

            string cadena = "";

            switch (comboBox1.SelectedIndex)
            {

                case 0:
                    if (indice >= oAlumno.Count)
                        indice = oAlumno.Count - 1;
                    cadena = oAlumno[indice].Id.ToString() + ". " + oAlumno[indice].Nombre + ", de " + oAlumno[indice].Ciudad + ", " + oAlumno[indice].Edad + " años.";
                    break;
                case 1:
                    if (indice >= oApoderado.Count)
                        indice = oApoderado.Count - 1;

                    using (Model.DBprac1Entities db = new Model.DBprac1Entities())
                    {
                        oAlumno = db.ALUMNO.ToList();
                        cadena = oApoderado[indice].Id.ToString() + ". " + oApoderado[indice].Nombre + ", es el|la opederado|a de " + oAlumno.Find(a => a.Id == (int)oApoderado[indice].Id_Alumno).Nombre;
                    }
                    break;
                case 2:
                    if (indice >= oCurso.Count)
                        indice = oCurso.Count - 1;
                    cadena = oCurso[indice].Cod.ToString() + ". " + oCurso[indice].Nombre + oCurso[indice].Fecha_Inicio + ", " + oCurso[indice].Duracion + " Horas" + oCurso[indice].Valor + " Pesos.";
                    break;
                case 3:
                    if (indice >= oInscrito.Count)
                        indice = oInscrito.Count - 1;
                    using (Model.DBprac1Entities db = new Model.DBprac1Entities())
                    {
                        oAlumno = db.ALUMNO.ToList();
                        oCurso = db.CURSO.ToList();
                        cadena = oInscrito[indice].Id.ToString() + ". " + oAlumno.Find(a => a.Id == (int)oInscrito[indice].Id_Alumno).Nombre + ". " + oCurso.Find(a => a.Cod == (int)oInscrito[indice].Cod_Curso).Nombre;
                    }
                    break;
            }
            textBox1.Text = cadena;
        }
    }
}