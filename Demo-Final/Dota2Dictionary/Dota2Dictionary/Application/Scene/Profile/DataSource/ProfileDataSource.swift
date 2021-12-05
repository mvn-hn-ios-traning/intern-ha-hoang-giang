//
//  ProfileDataSource.swift
//  Dota2Dictionary
//
//  Created by MacOS on 23/11/2021.
//

import Foundation
import RxDataSources

enum ProfileTableViewItem {
    case profileInfoItem(info: String)
    case profileSignOutItem(signout: String)
    case profileLikeItem(like: HeroLikedModel)
}

enum ProfileTableViewSection {
    case infoSection(items: [ProfileTableViewItem])
    case signoutSection(items: [ProfileTableViewItem])
    case likeSection(items: [ProfileTableViewItem])
}

extension ProfileTableViewSection: SectionModelType {
    typealias Item = ProfileTableViewItem
    
    var header: String {
        switch self {
        case .infoSection:
            return "Info"
        case .signoutSection:
            return "Sign Out"
        case .likeSection:
            return "Liked"
        }
    }
    
    var items: [ProfileTableViewItem] {
        switch self {
        case .infoSection(items: let items):
            return items
        case .signoutSection(items: let items):
            return items
        case .likeSection(items: let items):
            return items
        }
    }
    
    init(original: ProfileTableViewSection, items: [Self.Item]) {
        self = original
    }
}

struct ProfileDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<ProfileTableViewSection> {
        return .init(configureCell: { (dataSource, tableView, indexPath, _) -> UITableViewCell in
            
            switch dataSource[indexPath] {
            case .profileInfoItem(let info):
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: ConstantsForCell.profileInfoTableViewCell,
                                         for: indexPath) as? ProfileInfoTableViewCell
                    else { return UITableViewCell() }
                cell.configure(info)
                return cell
                
            case .profileSignOutItem(let signout):
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: ConstantsForCell.profileSignOutTableViewCell,
                                         for: indexPath) as? ProfileSignOutTableViewCell
                    else { return UITableViewCell() }
                cell.configure(signout)
                return cell
                
            case .profileLikeItem(let like):
                guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: ConstantsForCell.profileLikeTableViewCell,
                                         for: indexPath) as? ProfileLikeTableViewCell
                    else { return UITableViewCell() }
                cell.configure(like)
                return cell
            }
        },
                     titleForHeaderInSection: { dataSource, index in
                        return dataSource.sectionModels[index].header }
        )
    }
}
