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
    var a = Ruva.add(Ruva.add(Ruva.ruva_int(2),Ruva.ruva_int(2)),Ruva.ruva_int(2));
    a = Ruva.sub(Ruva.ruva_int(2),Ruva.ruva_int(2));
    a = Ruva.mul(Ruva.ruva_int(2),Ruva.ruva_int(2));
    a = Ruva.div(Ruva.ruva_int(2),Ruva.ruva_int(2));
    a = Ruva.mod(Ruva.ruva_int(2),Ruva.ruva_int(2));
    a = Ruva.sub(Ruva.pow(Ruva.ruva_int(2),Ruva.ruva_int(2)),Ruva.ruva_int(2));
    Ruva.puts(a);
    abacate();
    abacate();
    if (Ruva.truthy(Ruva.ruva_true()))
    {
      Ruva.puts(a,Ruva.ruva_int(2));
    }
    else if (Ruva.truthy(Ruva.ruva_true()))
    {
      Ruva.puts(a);
    }
    else
    {
      Ruva.puts(a);
    }
    while (Ruva.truthy(Ruva.ruva_true()))
    {
      var b = abacate();
      break;
    }
    while (Ruva.truthy(Ruva.ruva_false()))
    {
    }
    while (Ruva.truthy(Ruva.ruva_nil()))
    {
    }
    Ruva.add(Ruva.ruva_int(2),Ruva.ruva_int(2));
    var c = Ruva.ruva_str("aaa");
    Ruva.ruva_str("bbbb");
    var dd = Ruva.array();

    var bb = Ruva.array(Ruva.ruva_int(1), Ruva.ruva_int(2), Ruva.ruva_int(3), Ruva.ruva_str("s"));
    var bbb = Ruva.array(Ruva.ruva_int(1), Ruva.array(Ruva.ruva_int(2)));
    var dado = Ruva.hash(Ruva.ruva_sym("aaaaaa"), Ruva.ruva_int(2), Ruva.ruva_sym("daaaaa"), Ruva.ruva_int(4));
    Ruva.array(Ruva.ruva_int(1), Ruva.ruva_int(2));
    Ruva.hash(Ruva.ruva_sym("a"), Ruva.ruva_int(1), Ruva.ruva_sym("b"), Ruva.ruva_int(2), Ruva.ruva_sym("c"), Ruva.hash(Ruva.ruva_sym("d"), Ruva.ruva_int(5)));
    var daaaa = Ruva.gets();
  }
}
