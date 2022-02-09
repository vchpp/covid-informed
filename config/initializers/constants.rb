CI_LOCALE = {
  "vi-us"  => "vi",
  "hm-us" => "hmn",
  "zh-us" => "zh_TW",
  "en-us" => "en"
}

HW_LOCALE = {
  "vi"  => "vi-us",
  "hmn" => "hm-us",
  "zh_TW" => "zh-us",
  "zh_CN" => "zh-us",
  "en" => "en-us"
}

LOCALES = Regexp.union(
  /en-us/i,
  /zh-us/i,
  /vi-us/i,
  /hm-us/i,
)

VERBOSE_LOCALES = {
  "vi-us"  => "Tiếng Việt",
  "hm-us" => "lus hmoob",
  "zh-us" => "繁體中文",
  "en-us" => "English"
}
