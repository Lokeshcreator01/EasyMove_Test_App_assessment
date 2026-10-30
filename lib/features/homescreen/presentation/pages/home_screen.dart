import 'package:easymove/core/constants/api_Constsnts.dart';
import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/core/constants/img_constants.dart';
import 'package:easymove/features/homescreen/domain/entities/Realestste_Entity.dart';
import 'package:easymove/features/homescreen/presentation/cubit/realestate_cubit.dart';
import 'package:easymove/features/homescreen/presentation/cubit/realestate_state.dart';
import 'package:easymove/features/homescreen/presentation/widgets/widgets.dart';
import 'package:easymove/core/widgets/app_bottom_navigation.dart';
import 'package:easymove/features/homescreen/presentation/pages/side_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _selectedTab = 0;
  String _listingType = 'Buy';

  @override
  void initState() {
    super.initState();
    context.read<RealestateCubit>().getRealestate(ApiConstsnts.Realestate_Url);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RealestateCubit, UserState>(
      builder: (context, state) {
        final listings = state is RealestateSuccessState
            ? state.realestateEntity.listings
            : const <ListingEntity>[];
        final apiImageUrls = listings.expand((listing) => listing.images).map((
          image,
        ) {
          final path = image.imagePath.startsWith('/')
              ? image.imagePath.substring(1)
              : image.imagePath;
          return '${ApiConstsnts.Base_URL}/$path';
        }).toList();

        return Scaffold(
          key: _scaffoldKey,
          endDrawer: const SideBarScreen(),
          backgroundColor: HomeColors.background,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(97),
            child: Container(
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: HomeColors.bottomBar,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Image.asset(
                          ImgConstants.logo,
                          height: 38,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const SizedBox(height: 38),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        flex: 3,
                        child: Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.72),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  HomeStrings.countryHint,
                                  overflow: TextOverflow.ellipsis,
                                  style: WidgetStyle.country,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.notifications_none, size: 22),
                      const SizedBox(width: 5),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                        icon: const Icon(Icons.menu, size: 26),
                        onPressed: () =>
                            _scaffoldKey.currentState?.openEndDrawer(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        HomeHero(imageUrls: apiImageUrls),
                        HomePropertySection(
                          listings: listings,
                          listingType: _listingType,
                          onListingTypeChanged: (type) =>
                              setState(() => _listingType = type),
                        ),
                        HomeServiceSection(
                          title: HomeStrings.buyOrRentCars,
                          action: 'Explore Cars',
                          children: [
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 0),
                              label: 'Buy Car',
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 1),
                              label: 'Rent Car',
                            ),
                          ],
                        ),
                        HomeServiceSection(
                          title: HomeStrings.shortStays,
                          action: 'Explore Short Stays',
                          children: [
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 2),
                              label: 'Hotels',
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 3),
                              label: 'Resorts',
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 4),
                              label: 'Beach Stays',
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 5),
                              label: 'Cottage',
                            ),
                          ],
                        ),
                        HomeServiceSection(
                          title: HomeStrings.packersAndMovers,
                          action: 'Schedule Move',
                          children: [
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 1),
                              label: 'Residential Moving',
                              overlayLabel: false,
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 2),
                              label: 'Corporate Moving',
                              overlayLabel: false,
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 0),
                              label: 'Vehicle Shifting',
                              overlayLabel: false,
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 3),
                              label: 'Industrial Packing',
                              overlayLabel: false,
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 4),
                              label: 'Commercial Transportation',
                              overlayLabel: false,
                            ),
                            ScheduleMoveTile(),
                          ],
                        ),
                        HomeServiceSection(
                          title: HomeStrings.toursAndTravels,
                          action: 'Explore Travel Packages',
                          children: [
                            FeatureBanner(
                              imageUrl: _apiImage(apiImageUrls, 5),
                              title: WidgetsText.adventureAwaits,
                            ),
                          ],
                        ),
                        HomeServiceSection(
                          title: HomeStrings.designBuild,
                          action: 'Book Consultation',
                          children: [
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 0),
                              label: 'Construction',
                              overlayLabel: false,
                              showButton: true,
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 1),
                              label: 'Architect',
                              overlayLabel: false,
                              showButton: true,
                            ),
                            ServiceImageTile(
                              imageUrl: _apiImage(apiImageUrls, 2),
                              label: 'Interior Design',
                              overlayLabel: false,
                              showButton: true,
                            ),
                          ],
                        ),
                        HomeServiceSection(
                          title: HomeStrings.flights,
                          action: 'Book Flights',
                          children: [
                            FeatureBanner(
                              imageUrl: _apiImage(apiImageUrls, 3),
                              title: WidgetsText.bookAndFly,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                ),
                AppBottomNavigation(
                  selectedIndex: _selectedTab,
                  key: ValueKey(_selectedTab),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _apiImage(List<String> imageUrls, int index) {
    return index < imageUrls.length ? imageUrls[index] : '';
  }
}
