import 'package:easymove/core/constants/api_Constsnts.dart';
import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/core/constants/img_constants.dart';
import 'package:easymove/features/homescreen/domain/entities/Realestste_Entity.dart';
import 'package:flutter/material.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    required this.title,
    required this.action,
    super.key,
  });

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: HomeStyles.sectionTitle,
          ),
        ),
        Text(
          '$action  →',
          textAlign: TextAlign.right,
          style: HomeStyles.sectionAction,
        ),
      ],
    );
  }
}

class HomeImage extends StatelessWidget {
  const HomeImage({
    required this.url,
    required this.borderRadius,
    super.key,
    this.fit = BoxFit.cover,
    this.fallbackUrl,
  });

  final String url;
  final BorderRadius borderRadius;
  final BoxFit fit;
  final String? fallbackUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: _networkImage(
        url.isNotEmpty ? url : (fallbackUrl ?? ImgConstants.fallbackImages[0]),
      ),
    );
  }

  Widget _networkImage(String imageUrl) {
    final fallback = fallbackUrl ?? ImgConstants.fallbackImages[0];
    return Image.network(
      imageUrl,
      fit: fit,
      errorBuilder: (_, _, _) {
        if (imageUrl != fallback) {
          return Image.network(
            fallback,
            fit: fit,
            errorBuilder: (_, _, _) => _imagePlaceholder(),
          );
        }
        return _imagePlaceholder();
      },
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: HomeColors.cardBackground,
      child: const Icon(Icons.image_outlined, color: HomeColors.lightMuted),
    );
  }
}

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.location,
    required this.bedrooms,
    super.key,
    this.rating,
    this.discount,
    this.imageHeight = 100,
  });

  final String imageUrl;
  final String title;
  final String price;
  final String location;
  final int bedrooms;
  final String? rating;
  final String? discount;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HomeColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: HomeImage(
                  url: imageUrl,
                  borderRadius: BorderRadius.zero,
                  fallbackUrl: ImgConstants.fallbackImages[0],
                ),
              ),
              if (discount != null)
                Positioned(
                  top: 4,
                  left: 4,
                  child: Text(discount!, style: WidgetStyle.discount),
                ),
              const Positioned(
                top: 4,
                right: 4,
                child: Icon(
                  Icons.favorite_border,
                  size: 17,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 5, 6, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: HomeStyles.cardTitle),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 9,
                      color: HomeColors.muted,
                    ),
                    Text(location, style: HomeStyles.cardMeta),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text('$bedrooms Beds', style: HomeStyles.cardMeta),
                    ),
                    Text(price, style: HomeStyles.cardPrice),
                  ],
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: _SmallButton(label: WidgetsText.view),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  const _SmallButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: HomeColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: HomeStyles.button),
    );
  }
}

class ServiceImageTile extends StatelessWidget {
  const ServiceImageTile({
    required this.imageUrl,
    required this.label,
    super.key,
    this.large = false,
    this.overlayLabel = true,
    this.showButton = false,
  });

  final String imageUrl;
  final String label;
  final bool large;
  final bool overlayLabel;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    final image = AspectRatio(
      aspectRatio: large ? 1.15 : 1,
      child: HomeImage(
        url: imageUrl,
        borderRadius: BorderRadius.circular(9),
        fallbackUrl: ImgConstants.fallbackImages[1],
      ),
    );

    if (overlayLabel) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: image),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: HomeColors.primary,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text(label, style: HomeStyles.button),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: HomeColors.cardBackground,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: [
          image,
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: HomeStyles.serviceLabel,
          ),
          if (showButton) ...[
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: HomeColors.primary,
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Text(
                WidgetsText.viewProjects,
                style: HomeStyles.button,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class FeatureBanner extends StatelessWidget {
  const FeatureBanner({required this.imageUrl, required this.title, super.key});

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned.fill(
            child: HomeImage(
              url: imageUrl,
              borderRadius: BorderRadius.circular(9),
              fallbackUrl: ImgConstants.fallbackImages[2],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 50, 8),
            child: Text(title, style: WidgetStyle.bannerTitle),
          ),
        ],
      ),
    );
  }
}

class HomeHero extends StatefulWidget {
  const HomeHero({required this.imageUrls, super.key});

  final List<String> imageUrls;

  @override
  State<HomeHero> createState() => _HomeHeroState();
}

class _HomeHeroState extends State<HomeHero> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.84);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heroImages = List<String>.generate(
      3,
      (index) => index < widget.imageUrls.length ? widget.imageUrls[index] : '',
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
      child: SizedBox(
        height: 205,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: heroImages.length,
              onPageChanged: (page) => setState(() => _currentPage = page),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: HomeImage(
                  url: heroImages[index],
                  borderRadius: BorderRadius.circular(7),
                  fallbackUrl: ImgConstants.fallbackImages[index],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var index = 0; index < heroImages.length; index++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: index == _currentPage ? 8 : 7,
                      height: index == _currentPage ? 8 : 7,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: index == _currentPage
                            ? HomeColors.red
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePropertySection extends StatelessWidget {
  const HomePropertySection({
    required this.listings,
    required this.listingType,
    required this.onListingTypeChanged,
    super.key,
  });

  final List<ListingEntity> listings;
  final String listingType;
  final ValueChanged<String> onListingTypeChanged;

  String _imageUrlFor(ListingEntity listing) {
    if (listing.images.isEmpty) return '';
    final imagePath = listing.images.first.imagePath;
    final path = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
    return '${ApiConstsnts.Base_URL}/$path';
  }

  String _locationLabel(ListingEntity listing) {
    switch (listing.location) {
      case Googlemap.GHANA:
        return 'Ghana';
    }
  }

  bool _matchesListingType(ListingEntity listing) {
    switch (listingType) {
      case WidgetsText.buy:
        return listing.propertyList == PropertyList.SELL;
      case WidgetsText.rent:
        return listing.propertyList == PropertyList.RENT;
      case WidgetsText.lease:
        return listing.propertyList == PropertyList.LEASE;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredListings = listings.where(_matchesListingType).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 11, 17, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final type in [
                WidgetsText.buy,
                WidgetsText.rent,
                WidgetsText.lease,
              ])
                GestureDetector(
                  onTap: () => onListingTypeChanged(type),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 13),
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: listingType == type
                          ? const Border(
                              bottom: BorderSide(
                                color: HomeColors.red,
                                width: 2,
                              ),
                            )
                          : null,
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 9,
                        color: listingType == type
                            ? HomeColors.red
                            : HomeColors.dark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: HomeStrings.searchHint,
              hintStyle: WidgetStyle.searchHint,
              prefixIcon: const Icon(
                Icons.location_on_outlined,
                size: 15,
                color: HomeColors.lightMuted,
              ),
              suffixIcon: const Icon(
                Icons.search,
                size: 19,
                color: HomeColors.muted,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: HomeColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: HomeColors.border),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const HomeSectionHeader(
            title: HomeStrings.featuredListings,
            action: WidgetsText.viewAll,
          ),
          const SizedBox(height: 8),
          if (filteredListings.isEmpty)
            const SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'No listings available',
                  style: HomeStyles.cardMeta,
                ),
              ),
            )
          else
            Row(
              children: [
                for (
                  var index = 0;
                  index < 2 && index < filteredListings.length;
                  index++
                )
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index == 0 ? 9 : 0),
                      child: PropertyCard(
                        imageUrl: _imageUrlFor(filteredListings[index]),
                        title: filteredListings[index].propertyName,
                        price: 'GHC ${filteredListings[index].price}',
                        location: _locationLabel(filteredListings[index]),
                        bedrooms: filteredListings[index].bedrooms,
                        discount: index == 0 ? WidgetsText.discount : null,
                      ),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 13),
          const Text(HomeStrings.categories, style: WidgetStyle.category),
          const SizedBox(height: 9),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(WidgetsText.house, style: WidgetStyle.categoryItem),
              Text(WidgetsText.apartment, style: WidgetStyle.categoryItem),
              Text(WidgetsText.plot, style: WidgetStyle.categoryItem),
            ],
          ),
          const SizedBox(height: 10),
          for (final listing in filteredListings)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PropertyCard(
                imageUrl: _imageUrlFor(listing),
                title: listing.propertyName,
                price: 'GHC ${listing.price}',
                location: _locationLabel(listing),
                bedrooms: listing.bedrooms,
                rating: listing.isFavourite == 1 ? '4.5' : null,
                imageHeight: 145,
              ),
            ),
        ],
      ),
    );
  }
}

class HomeServiceSection extends StatelessWidget {
  const HomeServiceSection({
    required this.title,
    required this.action,
    required this.children,
    super.key,
  });

  final String title;
  final String action;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 25, 17, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeSectionHeader(title: title, action: action),
          const SizedBox(height: 11),
          GridView.count(
            crossAxisCount: children.length == 1
                ? 1
                : children.length == 2
                ? 2
                : 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 14,
            childAspectRatio: children.length == 1
                ? 2.35
                : children.length == 2
                ? 0.88
                : 0.7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          ),
        ],
      ),
    );
  }
}

class ScheduleMoveTile extends StatelessWidget {
  const ScheduleMoveTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HomeColors.cardBackground,
        borderRadius: BorderRadius.circular(9),
      ),
      alignment: Alignment.center,
      child: const Text(
        WidgetsText.scheduleMove,
        textAlign: TextAlign.center,
        style: WidgetStyle.scheduleMove,
      ),
    );
  }
}
