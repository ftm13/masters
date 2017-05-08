package server;

import java.util.ArrayList;
import java.util.List;

class Search {
    private String pName;
    private String lName;
    private List<String> list = new ArrayList<>();

    public List<String> getList() {
        return list;
    }

    public void setList(List<String> list) {
        this.list = list;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getlName() {
        return lName;
    }

    public void setlName(String lName) {
        this.lName = lName;
    }



}