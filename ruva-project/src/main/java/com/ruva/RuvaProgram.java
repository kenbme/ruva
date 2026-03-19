package com.ruva;

import static com.ruva.Ruva.*;

public class RuvaProgram
{
  public static RuvaObject abacate()
  {
    return ruva_int(2);
  }
  public static RuvaObject abacateiro()
  {
    return ruva_str("aaaaaa");
  }
  public static void main(String[] args)
  {
    var a = ruva_add(ruva_add(ruva_int(2),ruva_int(2)),ruva_int(2));
    a = ruva_sub(ruva_int(2),ruva_int(2));
    a = ruva_mul(ruva_int(2),ruva_int(2));
    a = ruva_div(ruva_int(2),ruva_int(2));
    a = ruva_mod(ruva_int(2),ruva_int(2));
    a = ruva_sub(ruva_pow(ruva_int(2),ruva_int(2)),ruva_int(2));
    ruva_puts(a);
    abacate();
    abacate();
    if (ruva_truthy(ruva_true()))
    {
      ruva_puts(a,ruva_int(2));
    }
    else if (ruva_truthy(ruva_true()))
    {
      ruva_puts(a);
    }
    else
    {
      ruva_puts(a);
    }
    while (ruva_truthy(ruva_true()))
    {
      var b = abacate();
      break;
    }
    while (ruva_truthy(ruva_false()))
    {
    }
    while (ruva_truthy(ruva_nil()))
    {
    }
    ruva_add(ruva_int(2),ruva_int(2));
    var c = ruva_str("aaa");
    ruva_str("bbbb");
    var dd = ruva_array();
    var bb = ruva_array(ruva_int(1), ruva_int(2), ruva_int(3), ruva_str("s"));
    var bbb = ruva_array(ruva_int(1), ruva_array(ruva_int(2)));
    var dado = ruva_hash(ruva_sym("aaaaaa"), ruva_int(2), ruva_sym("daaaaa"), ruva_int(4));
    ruva_array(ruva_int(1), ruva_int(2));
    ruva_hash(ruva_sym("a"), ruva_int(1), ruva_sym("b"), ruva_int(2), ruva_sym("c"), ruva_hash(ruva_sym("d"), ruva_int(5)));
    var daaaa = ruva_gets();
  }
}
