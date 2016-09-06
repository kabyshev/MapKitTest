//
//  AppDelegate.m
//  MapKitHomework
//
//  Created by Maxim Kabyshev on 07.04.16.
//  Copyright © 2016 Maxim Kabyshev. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*
 
 Ученик.
 
 1. Создайте массив из 10 - 30 рандомных студентов, прямо как раньше, только в этот раз пусть у них наряду с именем и фамилией будет еще и координата. Можете использовать структуру координаты, а можете просто два дабла - лонгитюд и латитюд.
 
 2. Координату генерируйте так, установите центр например в вашем городе и просто генерируйте небольшие отрицательные либо положительные числа, чтобы рандомно получалась координата от центра в пределах установленного радиуса.
 
 (Ну а если совсем не получается генерировать координату, то просто ставьте им заготовленные координаты - это не главное)
 
 3. После того, как вы сгенерировали своих студентов, покажите их всех на карте, причем в титуле пусть будет Имя и Фамилия а в сабтитуле год рождения. Можете для каждого студента создать свою аннотацию, а можете студентов подписать на протокол аннотаций и добавить их на карту напрямую - как хотите :)
 
 Студент.
 
 4. Добавьте кнопочку, которая покажет всех студентов на экране.
 
 5. Вместо пинов на карте используйте свои кастомные картинки, причем если студент мужского пола, то картинка должна быть одна, а для девушек другая.
 
 Мастер
 
 6. У каждого колаута (этого облачка над пином) сделайте кнопочку информации справа так, что когда я на нее нажимаю вылазит поповер, в котором в виде статической таблицы находится имя и фамилия студента, год рождения, пол и самое главное адрес.
 
 7. В случае если это телефон, то вместо поповера контроллер должен вылазить модально.
 
 Супермен
 
 8. Создайте аннотацию для места встречи и показывайте его на карте новымой соответствующей картинкой
 
 9. Место встречи можно перемещать по карте, а студентов нет
 
 10. Когда место встречи бросается на карту, то вокруг него надо рисовать 3 круга, с радиусами 5 км, 10 км и 15 км (используйте оверлеи)
 
 11. На какой-то полупрозрачной вьюхе в одном из углов вам надо показать сколько студентов попадают в какой круг. Суть такая, чем дальше студент живет, тем меньше вероятность что он придет на встречу. Расстояние от студента до места встречи рассчитывайте используя функцию для расчета расстояния между точками, поищите ее в фреймворке :)
 
 12. Сделайте на навигейшине кнопочку, по нажатию на которую, от рандомных студентов до нее будут проложены маршруты (типо студенты идут на сходку), притом вероятности генератора разные, зависит от круга, в котором они находятся, если он близко, то 90%, а если далеко - то 10%
*/

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
