using Microsoft.Analytics.Interfaces;
using Microsoft.Analytics.Types.Sql;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace USQL3b
{
    public class Udfs
    {
        static public string[] ExtractDomains(string URLs)
        {
            //Pattern: optional "http[s]", optional "www.", any number of xxx.xxx. etc. 
            string sPattern = @"(http(s)?://)?(www.)?([a-z]|[A-Z]|[0-9])+\.([a-z]|[A-Z]|[0-9]|\.)+";

            //Find any matches of the pattern in the string
            MatchCollection matches = Regex.Matches(URLs, sPattern, RegexOptions.IgnoreCase);

            //return domain
            //Match[] match = matches.Cast<Match>().ToArray();
            string[] match = matches.Cast<Match>().Select(m => m.Value).ToArray();

            return match;
        }
    }
}
