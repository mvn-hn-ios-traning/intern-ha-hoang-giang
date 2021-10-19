//
//  HeroDetailDataSource.swift
//  Dota2Dictionary
//
//  Created by MacOS on 18/10/2021.
//

import Foundation
import RxDataSources

enum HeroDetailTableViewItem {
    case heroInfoTableViewItem(info: HeroDetailViewModelPlus)
    case heroRolesTableViewItem
    case heroLanguageTableViewItem
    case heroStatTableViewItem
    case heroAbilitiesTableViewItem
    case heroTalentsTableViewItem
}

enum HeroDetailTableViewSection {
    case infoSection(items: [HeroDetailTableViewItem])
    case rolesSection(items: [HeroDetailTableViewItem])
    case languageSection(items: [HeroDetailTableViewItem])
    case statSection(items: [HeroDetailTableViewItem])
    case abilitiesSection(items: [HeroDetailTableViewItem])
    case talentsSection(items: [HeroDetailTableViewItem])
}

extension HeroDetailTableViewSection: SectionModelType {
    typealias Item = HeroDetailTableViewItem
    
    var header: String {
        switch self {
        case .infoSection:
            return "InfoSection"
        case .rolesSection:
            return "RolesSection"
        case .languageSection:
            return "LanguageSection"
        case .statSection:
            return "StatSection"
        case .abilitiesSection:
            return "AbilitiesSection"
        case .talentsSection:
            return "TalentsSection"
        }
    }
    
    var items: [HeroDetailTableViewItem] {
        switch self {
        case .infoSection(items: let items):
            return items
        case .rolesSection(items: let items):
            return items
        case .languageSection(items: let items):
            return items
        case .statSection(items: let items):
            return items
        case .abilitiesSection(items: let items):
            return items
        case .talentsSection(items: let items):
            return items
        }
    }
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}

struct HeroDetailDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<HeroDetailTableViewSection> {
        return .init { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            switch dataSource[indexPath] {
            case .heroInfoTableViewItem:
                let cell = HeroInfoTableViewCell()
                return cell
            case .heroRolesTableViewItem:
                let cell = HeroInfoTableViewCell()
                return cell
            case .heroLanguageTableViewItem:
                let cell = HeroInfoTableViewCell()
                return cell
            case .heroStatTableViewItem:
                let cell = HeroInfoTableViewCell()
                return cell
            case .heroAbilitiesTableViewItem:
                let cell = HeroInfoTableViewCell()
                return cell
            case .heroTalentsTableViewItem:
                let cell = HeroInfoTableViewCell()
                return cell
            }
        }
    }
}
