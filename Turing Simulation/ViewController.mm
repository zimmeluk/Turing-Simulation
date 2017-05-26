//
//  ViewController.mm
//  Turing Simulation
//
//  Created by Luke Zimmerman.
//  Copyright © 2017 Luke Zimmerman. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

// ----------
// C++ CODE
// ----------

#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
#include <fstream>

using namespace std;

struct action {
    int dir, move;
    bool accept;
    char read, edit;
    action(char r, char e, int m, int d, bool a) {
        read = r; edit = e; move = m; dir = d; accept = a;
    }
};

struct node {
    vector<action> actions;
};

bool turingMachine(vector<node> n, int accept, string s) {
    int state = 0;      // holds the state
    int reading = 1;    // holds the character we are currently reading
    
    for(int actI = 0; actI < n[state].actions.size(); actI++) {
        if(n[state].actions[actI].read == s[reading]) {
            // reading character
            cout << "Reading " << n[state].actions[actI].read << endl;
            
            // edit the character
            s[reading] = n[state].actions[actI].edit;
            
            // change the head
            reading += (int) n[state].actions[actI].dir;
            
            // move to the appropriate state
            state = n[state].actions[actI].move;
            
            // print relevant information
            cout << "  State  -> " << state << endl;
            cout << "  Head   -> " << s[reading] << endl;
            cout << "  String -> " << s << endl;
            
            // reset the state counter
            actI = -1;
            
            if( state == accept ) { return true; }
        }
    }
    return false;
}

bool input(const char* filename, string str) {
    ifstream infile(filename);
    
    //number of nodes/states
    int size;
    int acceptState;
    infile >> size;
    infile >> acceptState;
    
    vector<node> nodes(size);
    
    /*
     * s = state index
     * r = char reading from tape string
     * e = what to edit current reading to
     * m = which state index to move to
     * d = direction to move head on tape string;
     *     -1 = left, 0 = stay, 1 = right
     * a = if state is accept state
     */
    
    int d, s, m;
    bool a;
    char r, e;
    
    while(infile >> s >> r >> e >> m >> d >> a) {
        nodes[s].actions.push_back(action(r, e, m, d, a));
    }
    
    infile.close();
    
    if(turingMachine(nodes, acceptState, str)) {
        cout << "ACCEPT" << endl;
        return true;
    }
    else {
        cout << "REJECT" << endl;
        return false;
    }
}

// --------------------
// OBJECTTIVE-C++ CODE
// --------------------

// holds the path name of the uploaded file
NSString *pathName = @"/Users/lzimmerman/Documents/Education/College/Year 3/CS333/Final Exam/Solution/Turing Simulation/Turing Simulation/input.txt";

// holds the test string
NSString *testStringNS = @"";

// holds the transition text
NSString *transTextNS = @"";

// C++ vector containing file output
vector<string> transTextVec;

// number of transitions in the custom file
int numTrans = 0;

// holds the accept state text
NSString *acceptTextNS = @"";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // change the label to read only the filename
    NSString *fileName = [pathName lastPathComponent];
    // NSLog(@"%@", fileName);
    
    NSString* newStringVal = [NSString stringWithFormat:@"%s %@", "Selected File:", fileName];
    [_filePathLabel setStringValue:newStringVal];
    
    NSString* newTransLabel = [NSString stringWithFormat:@"%s %d", "Transitions:", numTrans];
    [_transLabel setStringValue:newTransLabel];
    
    NSString* newAcceptLabel = [NSString stringWithFormat:@"%s %@", "Accept:", acceptTextNS];
    [_acceptLabel setStringValue:newAcceptLabel];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (IBAction)uploadFile:(id)sender {
    // opens a file dialog and saves the file path
    NSOpenPanel *op = [NSOpenPanel openPanel];

    op.canChooseFiles          = true;
    op.canChooseDirectories    = false;
    op.allowsMultipleSelection = false;
    op.allowedFileTypes = [NSArray arrayWithObjects:@"txt", @"TXT", nil];
    
    if ([op runModal] == NSModalResponseOK) {
        NSURL* fileURL = [[op URLs] objectAtIndex:0];
        
        // save the file path as a string
        pathName = [fileURL path];
    }
    
    // change the label to read only the filename
    NSString *fileName = [pathName lastPathComponent];

    NSString* newStringVal = [NSString stringWithFormat:@"%s %@", "Selected File:", fileName];
    [_filePathLabel setStringValue:newStringVal];
}

- (IBAction)addTransitionButton:(id)sender {
    // get the transition and convert it to a string
    transTextNS = [_transitionText stringValue];
    string transTextCPP = string([transTextNS UTF8String]);
    
    // store the string in a vector for printing to a file
    transTextVec.push_back(transTextCPP);
    
    // update the number of transitions listed
    numTrans += 1;
    
    NSString* newTransLabel = [NSString stringWithFormat:@"%s %d", "Transitions:", numTrans];
    [_transLabel setStringValue:newTransLabel];
    
    if ( [[_acceptText stringValue] length] > 0) {
        NSString* newAcceptLabel = [NSString stringWithFormat:@"%s %@", "Accept:", [_acceptText stringValue]];
        acceptTextNS = [_acceptText stringValue];
        [_acceptLabel setStringValue:newAcceptLabel];
        
        // clear the value
        _acceptText.stringValue = @"";
    }
    
    // clear the values
    _transitionText.stringValue = @"";
}

- (IBAction)createCustomFile:(id)sender {
    // Create a new file conttaining the specified transitions
    ofstream customFile;
    customFile.open ("/Users/lzimmerman/Documents/Education/College/Year 3/CS333/Final Exam/Solution/Turing Simulation/Turing Simulation/custom.txt");
    
    customFile << numTrans << '\n';
    string acceptCPP = string([acceptTextNS UTF8String]);
    customFile << acceptCPP << '\n';
    
    // write the contents of the vector to the file
    for (auto it = transTextVec.begin(); it != transTextVec.end(); ++it) {
        customFile << *it << "\n";
    }
    
    customFile.close();
    
    pathName = @"/Users/lzimmerman/Documents/Education/College/Year 3/CS333/Final Exam/Solution/Turing Simulation/Turing Simulation/custom.txt";

    // change the label to read only the filename
    NSString *fileName = [pathName lastPathComponent];

    NSString* newStringVal = [NSString stringWithFormat:@"%s %@", "Selected File:", fileName];
    [_filePathLabel setStringValue:newStringVal];
}

- (IBAction)runTuringMachine:(id)sender {
    // convert the NSString to a C-style string
    string pathNameC = string([pathName UTF8String]);
    const char* pathNameCPP = pathNameC.c_str();
    
    // get the test string and convert it to a string
    testStringNS = [_testString stringValue];
    string testStringCPP = string([testStringNS UTF8String]);
    testStringCPP = '*' + testStringCPP + '*';
    
    // call the C++ input() function
    bool result = input(pathNameCPP, testStringCPP);
    if(result == true) {
        [_resultLabel setStringValue:@"ACCEPT"];
    } else {
        [_resultLabel setStringValue:@"REJECT"];
    }
}

@end
