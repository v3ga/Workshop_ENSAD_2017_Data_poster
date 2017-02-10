String getString(String[] a)
{
  String s = "";
  String sep = "";
  for (int i=0; i<a.length; i++)
  {
    s += sep+a[i];
    sep = " / ";
  }
  return s;
}