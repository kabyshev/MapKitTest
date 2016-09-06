//
//  Student.m
//  MapKitHomework
//
//  Created by Maxim Kabyshev on 07.04.16.
//  Copyright © 2016 Maxim Kabyshev. All rights reserved.
//

#import "Student.h"
#import "ViewController.h"

@implementation Student

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString *maleNames[] = {
    
    @"JAMES", @"JOHN", @"ROBERT", @"MICHAEL", @"WILLIAM", @"DAVID",
    @"RICHARD", @"CHARLES", @"JOSEPH", @"THOMAS", @"CHRISTOPHER",
    @"DANIEL", @"PAUL", @"MARK", @"DONALD", @"GEORGE", @"KENNETH",
    @"STEVEN", @"EDWARD", @"BRIAN", @"RONALD", @"ANTHONY", @"KEVIN",
    @"JASON", @"MATTHEW", @"GARY", @"TIMOTHY", @"JOSE", @"LARRY", @"JEFFREY",
    @"FRANK", @"SCOTT", @"ERIC", @"STEPHEN", @"ANDREW", @"RAYMOND",
    @"GREGORY", @"JOSHUA", @"JERRY", @"DENNIS", @"WALTER", @"PATRICK",
    @"PETER", @"HAROLD", @"DOUGLAS", @"HENRY", @"CARL", @"ARTHUR",
    @"RYAN", @"ROGER", @"JOE", @"JUAN", @"JACK", @"ALBERT", @"JONATHAN",
    @"JUSTIN", @"TERRY", @"KEITH", @"SAMUEL", @"WILLIE", @"RALPH",
    @"LAWRENCE", @"NICHOLAS", @"ROY"
};

static NSString* femaleNames[] = {
    
    @"Alexandra", @"Anna", @"Liz", @"Helen", @"Katty", @"Veronica",
    @"Jane", @"Cristina", @"Britney", @"Darya", @"Naomy", @"Maria",
    @"Angelika", @"Svetlana", @"Natalia", @"Marina", @"Margaret"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

static int namesCount = 50;

+ (Student *)generateStudent {
    
    Student *student = [[Student alloc] init];
    CGFloat maleOrFemale = (CGFloat)(arc4random() % 1000) / 1;
    
    if (maleOrFemale >= 2) {
        student.firstName = [maleNames[arc4random() % namesCount] capitalizedString];
        student.male = YES;
    } else {
        student.firstName = femaleNames[arc4random() % namesCount];
        student.male = NO;
    }
    
    student.firstName = [maleNames[arc4random() % namesCount] capitalizedString];
    student.lastName = lastNames[arc4random() % namesCount];
    student.year = 1980 + arc4random() % 20;

    return student;
}

@end
