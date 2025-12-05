#import "../lib.typ": contest-conf, render-problem
#import "problems.typ": problems

#show: contest-conf.with(
  problems: problems,
  enable-header-footer: true,
  enable-problem-list: true
)
