package com.ruva;

import java.util.*;

public class RuvaObject {

    public enum Type {
        INT, STRING, BOOL, NIL, ARRAY, HASH
    }

    public final Type type;
    public final Object value;

    public RuvaObject(Type type, Object value) {
        this.type = type;
        this.value = value;
    }

    public int asInt() {
        return (Integer) value;
    }

    public String asString() {
        return (String) value;
    }

    public boolean asBool() {
        return (Boolean) value;
    }

    @SuppressWarnings("unchecked")
    public List<RuvaObject> asArray() {
        return (List<RuvaObject>) value;
    }

    @SuppressWarnings("unchecked")
    public Map<String, RuvaObject> asHash() {
        return (Map<String, RuvaObject>) value;
    }

    @Override
    public String toString() {
        if (type == Type.NIL) return "nil";
        return String.valueOf(value);
    }
}
