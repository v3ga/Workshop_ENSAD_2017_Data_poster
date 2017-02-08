/**
 * @param img
 *    pixel array to create histogram for
 * @param numSamples
 *    number pixels to be sampled in image
 * @param tolerance
 *    color tolerance used to merge similar colors
 *    (based on RGB distance)
 * @param blendCols
 *    switch to enable color blending of binned colors
 * @return sorted histogram as ArrayList
 */
ArrayList createHistogramFromImage(int[] img, int numSamples, float tolerance, boolean blendCols) 
{
  ColorList srcCols=ColorList.createFromARGBArray(img, numSamples, false);
  ArrayList hist=new ArrayList();
  float maxFreq=1;
  for (Iterator<TColor> i=srcCols.iterator(); i.hasNext(); ) {
    TColor c=i.next();
    HistEntry existing=null;
    for (Iterator<HistEntry> j=hist.iterator(); j.hasNext(); ) {
      HistEntry e=j.next();
      if (e.col.distanceToRGB(c)<tolerance) {
        if (blendCols) e.col.blend(c, 1f/(e.freq+1));
        existing=e;
        break;
      }
    }
    if (existing!=null) {
      existing.freq++;
      if (existing.freq>maxFreq) maxFreq=existing.freq;
    } else {
      hist.add(new HistEntry(c));
    }
  }
  Collections.sort(hist);
  // rescale frequencies
  maxFreq=1f/srcCols.size();
  for (Iterator i=hist.iterator(); i.hasNext(); ) {
    HistEntry e=(HistEntry)i.next();
    e.freq*=maxFreq;
  }
  return hist;
}

/**
 * A single histogram entry, a coupling of color & frequency
 * Implements a comparator to sort histogram entries based on freq.
 */
class HistEntry implements Comparable 
{
  float freq;
  TColor col;

  HistEntry(TColor c) {
    col=c;
    freq=1;
  }

  int compareTo(Object e) {
    return -(int)(freq-((HistEntry)e).freq);
  }

  public String toString() {
    return col.toHex()+": "+freq;
  }
} 