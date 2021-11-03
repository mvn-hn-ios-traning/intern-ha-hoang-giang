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
    case heroRolesTableViewItem(roles: Roles)
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
        
        return .init(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
                        
            tableView.register(UINib(nibName: "HeroInfoTableViewCell",
                                     bundle: nil),
                               forCellReuseIdentifier: "HeroInfoTableViewCell")
            
            tableView.register(UINib(nibName: "HeroRolesTableViewCell",
                                     bundle: nil),
                               forCellReuseIdentifier: "HeroRolesTableViewCell")
            
            switch dataSource[indexPath] {
            case .heroInfoTableViewItem(let info):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroInfoTableViewCell",
                                                               for: indexPath) as? HeroInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(info)
                return cell
            case .heroRolesTableViewItem(let roles):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroRolesTableViewCell",
                                                               for: indexPath) as? HeroRolesTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(roles)
                
                return cell
            case .heroLanguageTableViewItem(let language):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroInfoTableViewCell",
                                                               for: indexPath) as? HeroInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(language)
                return cell
            case .heroStatTableViewItem(let stat):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroInfoTableViewCell",
                                                               for: indexPath) as? HeroInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(stat)
                return cell
            case .heroAbilitiesTableViewItem(let abilities):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroInfoTableViewCell",
                                                               for: indexPath) as? HeroInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(abilities)
                return cell
            case .heroTalentsTableViewItem(let talents):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroInfoTableViewCell",
                                                               for: indexPath) as? HeroInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(talents)
                return cell
            }
        })
    }
}
