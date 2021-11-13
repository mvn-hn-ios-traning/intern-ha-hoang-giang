//
//  ItemDetailDataSource.swift
//  Dota2Dictionary
//
//  Created by MacOS on 31/10/2021.
//

import Foundation
import RxDataSources

enum ItemDetailTableViewItem {
    case itemInfoTopItem(info: ItemDetailViewModelPlus)
    case itemHintItem(hint: ItemDetailViewModelPlus)
    case itemManaColdownItem(manacd: ItemDetailViewModelPlus)
    case itemNotesItem(notes: ItemDetailViewModelPlus)
    case itemAttribItem(attrib: ItemDetailViewModelPlus)
    case itemLoreItem(lore: ItemDetailViewModelPlus)
    case itemComponentsItem(components: ItemDetailViewModelPlus)
}

enum ItemDetailTableViewSection {
    case infoSection(items: [ItemDetailTableViewItem])
    case hintSection(items: [ItemDetailTableViewItem])
    case manacdSection(items: [ItemDetailTableViewItem])
    case notesSection(items: [ItemDetailTableViewItem])
    case attribSection(items: [ItemDetailTableViewItem])
    case loreSection(items: [ItemDetailTableViewItem])
    case componentsSection(items: [ItemDetailTableViewItem])
}

extension ItemDetailTableViewSection: SectionModelType {
    typealias Item = ItemDetailTableViewItem
    
    var items: [ItemDetailTableViewItem] {
        switch self {
        case .infoSection(items: let items):
            return items
        case .hintSection(items: let items):
            return items
        case .manacdSection(items: let items):
            return items
        case .notesSection(items: let items):
            return items
        case .attribSection(items: let items):
            return items
        case .loreSection(items: let items):
            return items
        case .componentsSection(items: let items):
            return items
        }
    }
    
    init(original: ItemDetailTableViewSection, items: [Self.Item]) {
        self = original
    }
}

struct ItemDetailDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<ItemDetailTableViewSection> {
        return .init(configureCell: { (dataSource, tableView, indexPath, _) -> UITableViewCell in
            
            switch dataSource[indexPath] {
            case .itemInfoTopItem(let info):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForCell.infoTopTableViewCell,
                                                               for: indexPath)
                    as? InfoTopTableViewCell else {
                        return UITableViewCell()
                }
                cell.configure(info)
                return cell
            case .itemHintItem(let hint):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForCell.itemHintTableViewCell,
                                                               for: indexPath)
                    as? ItemHintTableViewCell else {
                        return UITableViewCell()
                }
                cell.configure(hint)
                return cell
            case .itemManaColdownItem(let manacd):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForCell
                    .manaColdownTableViewCell,
                                                               for: indexPath)
                    as? ManaColdownTableViewCell else {
                        return UITableViewCell()
                }
                cell.configure(manacd)
                return cell
            case .itemNotesItem(let notes):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForCell.itemNotesTableViewCell,
                                                               for: indexPath)
                    as? ItemNotesTableViewCell else {
                        return UITableViewCell()
                }
                cell.configure(notes)
                return cell
            case.itemAttribItem(let attrib):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForCell.itemAttribTableViewCell,
                                                               for: indexPath)
                    as? ItemAttribTableViewCell else {
                        return UITableViewCell()
                }
                cell.configure(attrib)
                return cell
            case .itemLoreItem(let lore):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForCell.itemLoreTableViewCell,
                                                               for: indexPath)
                    as? ItemLoreTableViewCell else {
                        return UITableViewCell()
                }
                cell.configure(lore)
                return cell
            case .itemComponentsItem(let components):
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: ConstantsForCell.itemComponentTableViewCell,
                                         for: indexPath)
                    as? ItemComponentTableViewCell else {
                        return UITableViewCell()
                }
                cell.configure(components)
                return cell
            }
        })
    }
}
