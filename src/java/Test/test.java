/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Test;

/**
 *
 * @author VIVEK.SONI
 */
public class test {

   

    public static void main(String[] args) {
       int []arr={1,5,6,7,9,11,15,19};
       int j=0;
       int resul=18;
       int flag;
        int l = 0;
        for (int i = 0; i < arr.length; i++) {
            int k=arr[j];
            if(i+1< arr.length-1){
             l=arr[i+1];
            if((k+l)==resul)
            {
            System.out.println("Result Found value is"+k+" and "+l);
            flag=0;
            }else {
            flag=1;
            }
            }else{
            if(j==arr.length-1){
            break;
            }
            j++;
            i=0;
            }

           
            

        }

      

    }

}
