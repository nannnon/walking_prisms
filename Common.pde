boolean PrismExists(ArrayList<Prism> myPrisms, int x, int z)
{
  for (Prism p : myPrisms)
  {
    if (p.Exist(x, z))
    {
      return true;
    }
  }
  
  return false;
}
