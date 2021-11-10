//
//  HeroDetailDataSource.swift
//  Dota2Dictionary
//
//  Created by MacOS on 18/10/2021.
//

import Foundation
import RxDataSources

// MARK: Item
enum HeroDetailTableViewItem {
    case heroInfoTableViewItem(info: HeroDetailViewModelPlus)
    case heroRolesTableViewItem(roles: Roles)
    case heroLanguageTableViewItem(language: HeroDetailViewModelPlus)
    case heroStatTableViewItem(stat: HeroDetailViewModelPlus)
    case heroAbilitiesTableViewItem(abilities: HeroDetailViewModelPlus)
    case heroTalentsTableViewItem(talents: HeroDetailViewModelPlus)
}

// MARK: Section
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

// MARK: - DataSource
struct HeroDetailDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<HeroDetailTableViewSection> {
        
        return .init(configureCell: { (dataSource, tableView, indexPath, _) -> UITableViewCell in
                                    
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
