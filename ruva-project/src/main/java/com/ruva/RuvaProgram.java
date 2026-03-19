package com.ruva;

public class RuvaProgram
{
  public static RuvaObject abacate()
  {
    return Ruva.ruva_int(2);
  }
  public static RuvaObject abacateiro()
  {
    return Ruva.ruva_str("aaaaaa");
  }
  public static void main(String[] args)
  {
    var a = Ruva.ruva_add(Ruva.ruva_add(Ruva.ruva_int(2),Ruva.ruva_int(2)),Ruva.ruva_int(2));
    a = Ruva.ruva_sub(Ruva.ruva_int(2),Ruva.ruva_int(2));
    a = Ruva.ruva_mul(Ruva.ruva_int(2),Ruva.ruva_int(2));
    a = Ruva.ruva_div(Ruva.ruva_int(2),Ruva.ruva_int(2));
    a = Ruva.ruva_mod(Ruva.ruva_int(2),Ruva.ruva_int(2));
    a = Ruva.ruva_sub(Ruva.ruva_pow(Ruva.ruva_int(2),Ruva.ruva_int(2)),Ruva.ruva_int(2));
    Ruva.ruva_puts(a);
    abacate();
    abacate();
    if (Ruva.ruva_truthy(Ruva.ruva_true()))
    {
      Ruva.ruva_puts(a,Ruva.ruva_int(2));
    }
    else if (Ruva.ruva_truthy(Ruva.ruva_true()))
    {
      Ruva.ruva_puts(a);
    }
    else
    {
      Ruva.ruva_puts(a);
    }
    while (Ruva.ruva_truthy(Ruva.ruva_true()))
    {
      var b = abacate();
      break;
    }
    while (Ruva.ruva_truthy(Ruva.ruva_false()))
    {
    }
    while (Ruva.ruva_truthy(Ruva.ruva_nil()))
    {
    }
    Ruva.ruva_add(Ruva.ruva_int(2),Ruva.ruva_int(2));
    var c = Ruva.ruva_str("aaa");
    Ruva.ruva_str("bbbb");
    var dd = Ruva.ruva_array();
    var bb = Ruva.ruva_array(Ruva.ruva_int(1), Ruva.ruva_int(2), Ruva.ruva_int(3), Ruva.ruva_str("s"));
    var bbb = Ruva.ruva_array(Ruva.ruva_int(1), Ruva.ruva_array(Ruva.ruva_int(2)));
    var dado = Ruva.ruva_hash(Ruva.ruva_sym("aaaaaa"), Ruva.ruva_int(2), Ruva.ruva_sym("daaaaa"), Ruva.ruva_int(4));
    Ruva.ruva_array(Ruva.ruva_int(1), Ruva.ruva_int(2));
    Ruva.ruva_hash(Ruva.ruva_sym("a"), Ruva.ruva_int(1), Ruva.ruva_sym("b"), Ruva.ruva_int(2), Ruva.ruva_sym("c"), Ruva.ruva_hash(Ruva.ruva_sym("d"), Ruva.ruva_int(5)));
    var daaaa = Ruva.ruva_gets();
  }
}
