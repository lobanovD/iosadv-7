//
//  MainView.swift
//  iosadv-8
//
//  Created by Dmitrii Lobanov on 17.06.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Text("Авторизация прошла успешно!")
            .padding()
            .onAppear {
                // Сброс bage number после авторизации
                UIApplication.shared.applicationIconBadgeNumber = 0
                
                // Запрос разрешений на показ уведомлений
                if !UserDefaults.standard.bool(forKey: "alertPermissionsShowed") {
                    LocalNotificationsService.requestPermissions()
                    UserDefaults.standard.set(true, forKey: "alertPermissionsShowed")
                }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
