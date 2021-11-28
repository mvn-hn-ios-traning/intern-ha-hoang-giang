//
//  Constant.swift
//  Dota2Dictionary
//
//  Created by MacOS on 11/10/2021.
//

import Foundation

struct ConstantsForImageURL {
    static let heroImageForHeroVC =
        "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/"
    
    static let patchImage =
        "http://cdn.dota2.com/apps/dota2/images/"
    
    static let itemImageForItemVC =
        "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/"
    
    static let heroDetailAvatarImage =
        "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/crops/"
    
    static let heroAbilityImage =
        "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/"
    static let heroSelfie =
    "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/social/"
}

struct ConstantsForJsonUrl {
    // Hero Detail
    static let heroDetailAllInfo =
        "https://raw.githubusercontent.com/odota/dotaconstants/master/build/heroes.json"
    
    static let heroDetailRole =
        "https://api.stratz.com/api/v1/Hero/roles"
    
    static let heroAbilitiesId =
        "https://raw.githubusercontent.com/odota/dotaconstants/master/build/hero_abilities.json"
    
    static let heroDetailAbilities =
        "https://raw.githubusercontent.com/odota/dotaconstants/master/build/abilities.json"
    
    static let heroLores =
        "https://raw.githubusercontent.com/odota/dotaconstants/master/build/hero_lore.json"
    
    // Item
    static let itemViewModelLink =
        "https://raw.githubusercontent.com/odota/dotaconstants/master/build/item_ids.json"
    
    // Item Detail
    static let itemDetailViewModelLink =
        "https://raw.githubusercontent.com/odota/dotaconstants/master/build/items.json"
}

struct ConstantsForCell {
    // Patch ViewController
    static let patchTableViewCell = "PatchTableViewCell"
    
    // PatchDetail ViewController
    static let patchDetailTableViewCell = "PatchDetailTableViewCell"
    
    // Hero ViewController
    static let allHeroCollectionViewCell = "AllHeroCollectionViewCell"
    
    // HeroDetail
    static let heroInfoTableViewCell = "HeroInfoTableViewCell"
    static let heroRolesTableViewCell = "HeroRolesTableViewCell"
    static let rolesCollectionViewCell = "RolesCollectionViewCell"
    static let heroLanguageTableViewCell = "HeroLanguageTableViewCell"
    static let heroStatTableViewCell = "HeroStatTableViewCell"
    static let heroAbilitiesTableViewCell = "HeroAbilitiesTableViewCell"
    static let heroTalentsTableViewCell = "HeroTalentsTableViewCell"
    static let heroLoreTableViewCell = "HeroLoreTableViewCell"
    
    // Item ViewController
    static let itemsAllCollectionViewCell = "ItemsAllCollectionViewCell"
    
    // ItemDetail ViewController
    static let infoTopTableViewCell = "InfoTopTableViewCell"
    static let itemHintTableViewCell = "ItemHintTableViewCell"
    static let manaColdownTableViewCell = "ManaColdownTableViewCell"
    static let itemNotesTableViewCell = "ItemNotesTableViewCell"
    static let itemAttribTableViewCell = "ItemAttribTableViewCell"
    static let itemLoreTableViewCell = "ItemLoreTableViewCell"
    static let itemComponentTableViewCell = "ItemComponentTableViewCell"
    
    // Profile
    static let profileInfoTableViewCell = "ProfileInfoTableViewCell"
    static let profileSignOutTableViewCell  = "ProfileSignOutTableViewCell"
    static let profileLikeTableViewCell  = "ProfileLikeTableViewCell"

}
