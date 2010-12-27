#import <Foundation/Foundation.h>

// Modified version of code from
// http://iphonedevelopertips.com/general/using-nsscanner-to-convert-hex-to-rgb-color.html

void printColorInfoForHexColor(NSString *hexColor)
{
    hexColor = [[hexColor stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]
                 ] uppercaseString];  
    
    // String should be 6 or 7 characters if it includes '#'  
    if ([hexColor length] < 6) 
    {
        fprintf(stderr, "Invalid string: should be 6 or 7 characters (was %i)\n", (int)[hexColor length]);
        return;
    }
    
    // strip # if it appears  
    if ([hexColor hasPrefix:@"#"]) 
        hexColor = [hexColor substringFromIndex:1];  
    
    // if the value isn't 6 characters at this point return 
    // the color black	
    if ([hexColor length] != 6) 
    {
        return;
    }
    
    // Separate into r, g, b substrings  
    NSRange range;  
    range.location = 0;  
    range.length = 2; 
    
    NSString *rString = [hexColor substringWithRange:range];  
    
    range.location = 2;  
    NSString *gString = [hexColor substringWithRange:range];  
    
    range.location = 4;  
    NSString *bString = [hexColor substringWithRange:range];  
    
    // Scan values  
    unsigned int r, g, b;  
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  
    [[NSScanner scannerWithString:gString] scanHexInt:&g];  
    [[NSScanner scannerWithString:bString] scanHexInt:&b];  
    
    // 8-bit ints
    fprintf(stdout, "\n");
    fprintf(stdout, "  red: %i\n", r);
    fprintf(stdout, "green: %i\n", g);
    fprintf(stdout, " blue: %i\n", b);
    

    // Floats
    fprintf(stdout, "\n");
    fprintf(stdout, "  red: %f\n", (float)r/255.0f);
    fprintf(stdout, "green: %f\n", (float)g/255.0f);
    fprintf(stdout, " blue: %f\n", (float)b/255.0f);

    // UIColor 
    fprintf(stdout, "\n");
    fprintf(stdout, "[UIColor colorWithRed:%f green:%f blue:%f alpha:1.0f];\n\n",
            (float)r/255.0f, (float)r/255.0f, (float)r/255.0f);
}

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    for(int i=1; i < argc; i++)
        printColorInfoForHexColor([NSString stringWithUTF8String:argv[i]]);
    
    [pool drain];
    return 0;
}
