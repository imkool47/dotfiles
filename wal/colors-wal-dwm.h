static const char norm_fg[] = "#c3c4c5";
static const char norm_bg[] = "#111618";
static const char norm_border[] = "#5b6b70";

static const char sel_fg[] = "#c3c4c5";
static const char sel_bg[] = "#9E7F80";
static const char sel_border[] = "#c3c4c5";

static const char urg_fg[] = "#c3c4c5";
static const char urg_bg[] = "#AD877B";
static const char urg_border[] = "#AD877B";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
