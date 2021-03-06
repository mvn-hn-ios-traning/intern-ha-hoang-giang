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
    case heroRolesTableViewItem(roles: HeroDetailViewModelPlus)
    case heroLanguageTableViewItem(language: HeroDetailViewModelPlus)
    case heroStatTableViewItem(stat: HeroDetailViewModelPlus)
    case heroAbilitiesTableViewItem(abilities: HeroDetailAbilitiesModel)
    case heroTalentsTableViewItem(talents: HeroDetailViewModelPlus)
    case heroLoreTableViewItem(lore: HeroDetailViewModelPlus)
}

// MARK: Section
enum HeroDetailTableViewSection {
    case infoSection(items: [HeroDetailTableViewItem])
    case rolesSection(items: [HeroDetailTableViewItem])
    case languageSection(items: [HeroDetailTableViewItem])
    case statSection(items: [HeroDetailTableViewItem])
    case abilitiesSection(items: [HeroDetailTableViewItem])
    case talentsSection(items: [HeroDetailTableViewItem])
    case loreSection(items: [HeroDetailTableViewItem])
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
        case .loreSection(items: let items):
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForCell.heroInfoTableViewCell,
                                                               for: indexPath) as? HeroInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(info)
                return cell
            case .heroRolesTableViewItem(let roles):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForCell.heroRolesTableViewCell,
                                                               for: indexPath) as? HeroRolesTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(roles)
                return cell
            case .heroLanguageTableViewItem(let language):
                guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ConstantsForCell.heroLanguageTableViewCell,
                                             for: indexPath) as? HeroLanguageTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(language)
                return cell
            case .heroStatTableViewItem(let stat):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForCell.heroStatTableViewCell,
                                                               for: indexPath) as? HeroStatTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(stat)
                return cell
            case .heroAbilitiesTableViewItem(let abilities):
                guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ConstantsForCell.heroAbilitiesTableViewCell,
                                             for: indexPath) as? HeroAbilitiesTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(abilities)
                return cell
            case .heroTalentsTableViewItem(let talents):
                guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ConstantsForCell.heroTalentsTableViewCell,
                                                               for: indexPath) as? HeroTalentsTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(talents)
                return cell
            case .heroLoreTableViewItem(let lore):
                guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ConstantsForCell.heroLoreTableViewCell,
                                                               for: indexPath) as? HeroLoreTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(lore)
                return cell
            }
        })
    }
}
