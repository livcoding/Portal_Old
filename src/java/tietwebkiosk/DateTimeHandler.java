package tietwebkiosk;

import java.util.*;
import java.text.*;
public class DateTimeHandler {

public DateTimeHandler(){}

public static String formatDateTime(String date,String format){
  Long datetime=new Long(date);
  SimpleDateFormat sdf=new SimpleDateFormat(format);
  FieldPosition pos = new FieldPosition(0);
  StringBuffer empty = new StringBuffer();
  StringBuffer datebuf = sdf.format(datetime, empty, pos);
  return datebuf.toString();
}

public static String formatDate(Date date,String format){

 SimpleDateFormat sdf=new SimpleDateFormat(format);
 FieldPosition pos = new FieldPosition(0);
 StringBuffer empty = new StringBuffer();
 StringBuffer datebuf = sdf.format(date, empty, pos);
 return datebuf.toString();
}
public static String formatDate(long date,String format){
SimpleDateFormat sdf=new SimpleDateFormat(format);
FieldPosition pos = new FieldPosition(0);
StringBuffer empty = new StringBuffer();
StringBuffer datebuf = sdf.format(new Long(date), empty, pos);
return datebuf.toString();
}

public static String formatDate(String date,String format){

SimpleDateFormat sdf=new SimpleDateFormat(format);
FieldPosition pos = new FieldPosition(0);
StringBuffer empty = new StringBuffer();
Date date1=null;
try {
date1=sdf.parse(date);
}
catch (Exception ex) {
 ex.printStackTrace();
}

StringBuffer datebuf = sdf.format(date1, empty, pos);
return datebuf.toString();
}

}

