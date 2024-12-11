const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#111618", /* black   */
  [1] = "#AD877B", /* red     */
  [2] = "#9E7F80", /* green   */
  [3] = "#7C9682", /* yellow  */
  [4] = "#95A48D", /* blue    */
  [5] = "#AFAE95", /* magenta */
  [6] = "#B8BAA4", /* cyan    */
  [7] = "#c3c4c5", /* white   */

  /* 8 bright colors */
  [8]  = "#5b6b70",  /* black   */
  [9]  = "#AD877B",  /* red     */
  [10] = "#9E7F80", /* green   */
  [11] = "#7C9682", /* yellow  */
  [12] = "#95A48D", /* blue    */
  [13] = "#AFAE95", /* magenta */
  [14] = "#B8BAA4", /* cyan    */
  [15] = "#c3c4c5", /* white   */

  /* special colors */
  [256] = "#111618", /* background */
  [257] = "#c3c4c5", /* foreground */
  [258] = "#c3c4c5",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
