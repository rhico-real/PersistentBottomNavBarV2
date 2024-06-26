part of "../persistent_bottom_nav_bar_v2.dart";

class Style1BottomNavBar extends StatelessWidget {
  const Style1BottomNavBar({
    required this.navBarConfig,
    super.key,
    this.navBarDecoration = const NavBarDecoration(),
  });

  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;

  Widget _buildItem(ItemConfig item, bool isSelected) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: 2, end: -12),
              badgeContent: Text(
                item.badgeString ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              showBadge: item.showBadge ?? false,
              child: IconTheme(
                  data: IconThemeData(
                    size: item.iconSize,
                    color: isSelected
                        ? item.activeForegroundColor
                        : item.inactiveForegroundColor,
                  ),
                  child: isSelected
                      ? SvgPicture.asset(item.iconString!,
                          color: item.activeForegroundColor)
                      : SvgPicture.asset(item.iconString!, color: Colors.grey)),
            ),
          ),
          if (item.title != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Material(
                type: MaterialType.transparency,
                child: FittedBox(
                  child: Text(
                    item.title!,
                    style: item.textStyle.apply(
                      color: isSelected
                          ? item.activeForegroundColor
                          : item.inactiveForegroundColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );

  @override
  Widget build(BuildContext context) => DecoratedNavBar(
        decoration: navBarDecoration,
        filter: navBarConfig.selectedItem.filter,
        opacity: navBarConfig.selectedItem.opacity,
        height: navBarConfig.navBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navBarConfig.items.map((item) {
            final int index = navBarConfig.items.indexOf(item);
            return Expanded(
              child: InkWell(
                onTap: () {
                  navBarConfig.onItemSelected(index);
                  if (item.onTap != null) {
                    // ignore: prefer_null_aware_method_calls
                    item.onTap!();
                  }
                },
                child: _buildItem(
                  item,
                  navBarConfig.selectedIndex == index,
                ),
              ),
            );
          }).toList(),
        ),
      );
}
