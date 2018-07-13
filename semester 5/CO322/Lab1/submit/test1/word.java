/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author shehan shaman
 */
public class word {
    
    private String key;
    private int count;
    private word next;
    
    public word(String key){
        this.key = key;
        this.count = 1;
        this.next = null;
    }
    
    public String getKey(){
        return this.key;
    }
    
    public int getCount(){
        return this.count;
    }
    
    public word getNext(){
        return this.next;
    }
    
    public void incCount(){
        this.count++;
    }
    
    public void setNext(word w){
        this.next = w;
    } 
}
