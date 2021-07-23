/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.html;

/**
 *
 * @author Mohit.sharma
 */
public class CommonHtmlComponent {
    
 public String tr(String td){
     return "<tr>"+td+"</tr>";
 }
 public String td(String El){
     return "<td>"+El+"</td>";
 }
 public String td_with_style(String El){
     return "<td style='text-align:left'>"+El+"</td>";
 }
 public String hLable(String lname,String req){
     StringBuffer la  =new StringBuffer();
     la.append(lname);
     if(req.equals("Y"))
     la.append("<span class='req'> *</span>");
     return la.toString();
 }
 public String inputBox(String name,String id,String hclass,String maxlength,String value,String title,String style,String ftype,String function){
     StringBuffer box  =new StringBuffer();
      box.append("<input type='"+ftype+"' name='"+name+"' id='"+id+"' value='"+value+"' maxlength='"+maxlength+"' class='"+hclass+"' style='"+style+"' title='"+title+"' "+function+"/>");
     return box.toString();
 }
 public String comboBox(String name,String id,String hclass,String title,String style){
     StringBuffer box  =new StringBuffer();
      box.append("<select  name='"+name+"' id='"+id+"'  class='"+hclass+"' style='"+style+"'  title='"+title+"'></select>");
     return box.toString();
 }
 public String checkBox(String name,String id,String hclass,String value,String style,String checked){
     StringBuffer box  =new StringBuffer();
      box.append("<input    type='checkbox' name='"+name+"' id='"+id+"' value='"+value+"' class='"+hclass+"' style='"+style+"' "+(checked.equals("Y")?"checked":"")+"/>");
     return box.toString();
 }
// public String redioButton(String name,String id,String hclass,String maxlength,String value,String style){
//     StringBuffer box  =new StringBuffer();
//      box.append("<input type='text' name='"+name+"' id='"+id+"' value='"+value+"' maxlength='"+maxlength+"' class='"+hclass+"' style=\""+style+"\"/>");
//     return box.toString();
// }
//    public static void main(String[] args) {
//        HtmlComponent a = new HtmlComponent();
//        System.out.print(a.tr(a.td(a.hLable("Yatend","Y"))+a.td(a.hLable("XXX","Y"))));
//         switch (Day.valueOf((String) "")) {
//                        case MON:
//
//                            break;
//                    }
//    }
}

