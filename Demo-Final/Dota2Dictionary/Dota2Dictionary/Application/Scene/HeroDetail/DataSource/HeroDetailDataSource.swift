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
    case heroRolesTableViewItem(roles: HeroDetailViewModelPlus)
    case heroLanguageTableViewItem(language: HeroDetailViewModelPlus)
    case heroStatTableViewItem(stat: HeroDetailViewModelPlus)
    case heroAbilitiesTableViewItem(abilities: HeroDetailViewModelPlus)
    case heroTalentsTableViewItem(talents: HeroDetailViewModelPlus)
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
        
        return .init (configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            
            switch dataSource[indexPath] {
            case let .heroInfoTableViewItem(info):
                let cell = HeroInfoTableViewCell()
                cell.configure(info)
                return cell
            case let .heroRolesTableViewItem(roles):
                let cell = HeroInfoTableViewCell()
                cell.configure(roles)
                return cell
            case let .heroLanguageTableViewItem(language):
                let cell = HeroInfoTableViewCell()
                cell.configure(language)
                return cell
            case let .heroStatTableViewItem(stat):
                let cell = HeroInfoTableViewCell()
                cell.configure(stat)
                return cell
            case let .heroAbilitiesTableViewItem(abilities):
                let cell = HeroInfoTableViewCell()
                cell.configure(abilities)
                return cell
            case let .heroTalentsTableViewItem(talents):
                let cell = HeroInfoTableViewCell()
                cell.configure(talents)
                return cell
            }
        }, titleForHeaderInSection: { dataSource, index in // bỏ titleForHeaderInSection sẽ mất tên của section ^^
            return dataSource.sectionModels[index].header
        })
    }
}
