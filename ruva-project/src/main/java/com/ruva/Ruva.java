package com.ruva;

import java.util.*;

public class Ruva {

    // ===== PRIMITIVOS =====

    public static RuvaObject ruva_int(int v) {
        return new RuvaObject(RuvaObject.Type.INT, v);
    }

    public static RuvaObject ruva_str(String v) {
        return new RuvaObject(RuvaObject.Type.STRING, v);
    }

    public static RuvaObject ruva_true() {
        return new RuvaObject(RuvaObject.Type.BOOL, true);
    }

    public static RuvaObject ruva_false() {
        return new RuvaObject(RuvaObject.Type.BOOL, false);
    }

    public static RuvaObject ruva_nil() {
        return new RuvaObject(RuvaObject.Type.NIL, null);
    }

    public static RuvaObject ruva_sym(String s) {
        return ruva_str(s); // simplificação
    }

    // ===== ARITMÉTICA =====

    public static RuvaObject add(RuvaObject a, RuvaObject b) {
        return ruva_int(a.asInt() + b.asInt());
    }

    public static RuvaObject sub(RuvaObject a, RuvaObject b) {
        return ruva_int(a.asInt() - b.asInt());
    }

    public static RuvaObject mul(RuvaObject a, RuvaObject b) {
        return ruva_int(a.asInt() * b.asInt());
    }

    public static RuvaObject div(RuvaObject a, RuvaObject b) {
        return ruva_int(a.asInt() / b.asInt());
    }

    public static RuvaObject mod(RuvaObject a, RuvaObject b) {
        return ruva_int(a.asInt() % b.asInt());
    }

    public static RuvaObject pow(RuvaObject a, RuvaObject b) {
        return ruva_int((int) Math.pow(a.asInt(), b.asInt()));
    }

    // ===== VERDADE =====

    public static boolean truthy(RuvaObject obj) {
        if (obj.type == RuvaObject.Type.NIL) return false;
        if (obj.type == RuvaObject.Type.BOOL) return obj.asBool();
        return true;
    }

    // ===== IO =====

    public static void puts(RuvaObject... objs) {
        for (RuvaObject o : objs) {
            System.out.print(o + " ");
        }
        System.out.println();
    }

    public static RuvaObject gets() {
        Scanner sc = new Scanner(System.in);
        return ruva_str(sc.nextLine());
    }

    // ===== ARRAYS =====

    public static RuvaObject array(RuvaObject... objs) {
        List<RuvaObject> list = new ArrayList<>();
        Collections.addAll(list, objs);
        return new RuvaObject(RuvaObject.Type.ARRAY, list);
    }

    // ===== HASH =====

    public static RuvaObject hash(RuvaObject... objs) {
        Map<String, RuvaObject> map = new HashMap<>();

        for (int i = 0; i < objs.length; i += 2) {
            String key = objs[i].toString();
            RuvaObject value = objs[i + 1];
            map.put(key, value);
        }

        return new RuvaObject(RuvaObject.Type.HASH, map);
    }
}
