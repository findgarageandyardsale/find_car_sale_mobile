import 'package:findcarsale/shared/domain/models/attachment_file/attachment_model.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/domain/models/paginated_response.dart';

class DummyDataService {
  static List<Garageayard> getDummyGarageYardList() {
    return [
      Garageayard(
        id: 1,
        title: "2019 Honda Civic - Excellent Condition",
        description:
            "Well-maintained Honda Civic with low mileage. Single owner, no accidents. Regular service records available. Perfect for daily commuting.",
        price: 18500.0,
        status: StatusEnum.active,
        type: GarageYardType.garage,
        location: LocationModel.fromJson({
          "id": 1,
          "latitude": 27.7172,
          "longitude": 85.3240,
          "sub_locality": "Suite 101",
          "locality": "Kathmandu",
          "sub_admin_area": "Kathmandu District",
          "admin_area": "Bagmati Province",
          "address_line": "123 Main Street",
          "zip_code": "44600",
          "apartment_number": "A-101",
          "sub_thoroughfare": "1234",
          "throughfare": "Durbar Marg",
        }),
        condition: CarCondition.fromJson({"id": 1, "name": "Excellent"}),
        attachments: [
          AttachmentModel(
            id: 1,
            file:
                "https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400",
            name: "honda_civic_1.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
          AttachmentModel(
            id: 2,
            file:
                "https://images.unsplash.com/photo-1549317336-206569e8475c?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1549317336-206569e8475c?w=400",
            name: "honda_civic_2.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
        ],
        isNew: false,
        warranty: true,
        miles: 45000.0,
        model: "Civic",
        brand: "Honda",
        year: "2019",
        phoneNumber: "+977-9841234567",
        availableTimeSlots: [
          AvailableTimeSlot.fromJson({
            "id": 1,
            "date":
                DateTime.now().add(const Duration(days: 1)).toIso8601String(),
            "start_time": "9:00 AM",
            "end_time": "5:00 PM",
            "is_editable": true,
            "garage_yard_id": 1,
          }),
          AvailableTimeSlot.fromJson({
            "id": 2,
            "date":
                DateTime.now().add(const Duration(days: 2)).toIso8601String(),
            "start_time": "10:00 AM",
            "end_time": "4:00 PM",
            "is_editable": true,
            "garage_yard_id": 1,
          }),
        ],
      ),
      Garageayard(
        id: 2,
        title: "2020 Toyota Corolla - Like New",
        description:
            "Barely used Toyota Corolla with all the latest features. Still under manufacturer warranty. Great fuel efficiency and reliability.",
        price: 22000.0,
        status: StatusEnum.active,
        type: GarageYardType.yard,
        location: LocationModel.fromJson({
          "id": 2,
          "latitude": 27.6588,
          "longitude": 85.3247,
          "sub_locality": "Suite 201",
          "locality": "Lalitpur",
          "sub_admin_area": "Lalitpur District",
          "admin_area": "Bagmati Province",
          "address_line": "456 Patan Durbar Square",
          "zip_code": "44700",
          "apartment_number": "B-201",
          "sub_thoroughfare": "5678",
          "throughfare": "Jhamsikhel Rd",
        }),
        condition: CarCondition.fromJson({"id": 2, "name": "Like New"}),
        attachments: [
          AttachmentModel(
            id: 3,
            file:
                "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400",
            name: "toyota_corolla_1.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
        ],
        isNew: false,
        warranty: true,
        miles: 25000.0,
        model: "Corolla",
        brand: "Toyota",
        year: "2020",
        phoneNumber: "+977-9842345678",
        availableTimeSlots: [
          AvailableTimeSlot.fromJson({
            "id": 3,
            "date":
                DateTime.now().add(const Duration(days: 3)).toIso8601String(),
            "start_time": "8:00 AM",
            "end_time": "6:00 PM",
            "is_editable": true,
            "garage_yard_id": 2,
          }),
        ],
      ),
      Garageayard(
        id: 3,
        title: "2018 Ford Mustang GT - Performance Beast",
        description:
            "High-performance Ford Mustang GT with V8 engine. Perfect for car enthusiasts. Recently serviced and detailed. Ready to hit the road!",
        price: 35000.0,
        status: StatusEnum.active,
        type: GarageYardType.garage,
        location: LocationModel.fromJson({
          "id": 3,
          "latitude": 27.7000,
          "longitude": 85.3000,
          "sub_locality": "Suite 301",
          "locality": "Bhaktapur",
          "sub_admin_area": "Bhaktapur District",
          "admin_area": "Bagmati Province",
          "address_line": "789 Bhaktapur Durbar Square",
          "zip_code": "44800",
          "apartment_number": "C-301",
          "sub_thoroughfare": "9012",
          "throughfare": "Durbar Square Rd",
        }),
        condition: CarCondition.fromJson({"id": 3, "name": "Good"}),
        attachments: [
          AttachmentModel(
            id: 4,
            file:
                "https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?w=400",
            name: "ford_mustang_1.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
          AttachmentModel(
            id: 5,
            file:
                "https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=400",
            name: "ford_mustang_2.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
          AttachmentModel(
            id: 6,
            file:
                "https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=400",
            name: "ford_mustang_3.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
        ],
        isNew: false,
        warranty: false,
        miles: 65000.0,
        model: "Mustang GT",
        brand: "Ford",
        year: "2018",
        phoneNumber: "+977-9843456789",
        availableTimeSlots: [
          AvailableTimeSlot.fromJson({
            "id": 4,
            "date":
                DateTime.now().add(const Duration(days: 4)).toIso8601String(),
            "start_time": "10:00 AM",
            "end_time": "4:00 PM",
            "is_editable": true,
            "garage_yard_id": 3,
          }),
          AvailableTimeSlot.fromJson({
            "id": 5,
            "date":
                DateTime.now().add(const Duration(days: 5)).toIso8601String(),
            "start_time": "9:00 AM",
            "end_time": "5:00 PM",
            "is_editable": true,
            "garage_yard_id": 3,
          }),
        ],
      ),
      Garageayard(
        id: 4,
        title: "2021 Tesla Model 3 - Electric Luxury",
        description:
            "Cutting-edge Tesla Model 3 with autopilot features. Zero emissions, incredible acceleration, and premium interior. The future of driving is here!",
        price: 45000.0,
        status: StatusEnum.active,
        type: GarageYardType.yard,
        location: LocationModel.fromJson({
          "id": 4,
          "latitude": 27.7500,
          "longitude": 85.3500,
          "sub_locality": "Suite 401",
          "locality": "Kathmandu",
          "sub_admin_area": "Kathmandu District",
          "admin_area": "Bagmati Province",
          "address_line": "321 Boudha Stupa",
          "zip_code": "44600",
          "apartment_number": "D-401",
          "sub_thoroughfare": "3456",
          "throughfare": "Boudha Rd",
        }),
        condition: CarCondition.fromJson({"id": 4, "name": "Excellent"}),
        attachments: [
          AttachmentModel(
            id: 7,
            file:
                "https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=400",
            name: "tesla_model3_1.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
          AttachmentModel(
            id: 8,
            file:
                "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400",
            name: "tesla_model3_2.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
        ],
        isNew: true,
        warranty: true,
        miles: 15000.0,
        model: "Model 3",
        brand: "Tesla",
        year: "2021",
        phoneNumber: "+977-9844567890",
        availableTimeSlots: [
          AvailableTimeSlot.fromJson({
            "id": 6,
            "date":
                DateTime.now().add(const Duration(days: 6)).toIso8601String(),
            "start_time": "9:00 AM",
            "end_time": "5:00 PM",
            "is_editable": true,
            "garage_yard_id": 4,
          }),
        ],
      ),
      Garageayard(
        id: 5,
        title: "2017 BMW 3 Series - Luxury Sedan",
        description:
            "Premium BMW 3 Series with leather interior and advanced features. Well-maintained by authorized dealer. Perfect blend of performance and comfort.",
        price: 28000.0,
        status: StatusEnum.active,
        type: GarageYardType.garage,
        location: LocationModel.fromJson({
          "id": 5,
          "latitude": 27.6800,
          "longitude": 85.3100,
          "sub_locality": "Suite 501",
          "locality": "Kathmandu",
          "sub_admin_area": "Kathmandu District",
          "admin_area": "Bagmati Province",
          "address_line": "654 Thamel",
          "zip_code": "44600",
          "apartment_number": "E-501",
          "sub_thoroughfare": "7890",
          "throughfare": "Thamel Marg",
        }),
        condition: CarCondition.fromJson({"id": 5, "name": "Very Good"}),
        attachments: [
          AttachmentModel(
            id: 9,
            file:
                "https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400",
            name: "bmw_3series_1.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
        ],
        isNew: false,
        warranty: false,
        miles: 75000.0,
        model: "3 Series",
        brand: "BMW",
        year: "2017",
        phoneNumber: "+977-9845678901",
        availableTimeSlots: [
          AvailableTimeSlot.fromJson({
            "id": 7,
            "date":
                DateTime.now().add(const Duration(days: 7)).toIso8601String(),
            "start_time": "8:00 AM",
            "end_time": "6:00 PM",
            "is_editable": true,
            "garage_yard_id": 5,
          }),
          AvailableTimeSlot.fromJson({
            "id": 8,
            "date":
                DateTime.now().add(const Duration(days: 8)).toIso8601String(),
            "start_time": "10:00 AM",
            "end_time": "4:00 PM",
            "is_editable": true,
            "garage_yard_id": 5,
          }),
        ],
      ),
      Garageayard(
        id: 6,
        title: "2019 Nissan Altima - Reliable Family Car",
        description:
            "Spacious and reliable Nissan Altima perfect for families. Great fuel economy and comfortable ride. Regular maintenance records available.",
        price: 19500.0,
        status: StatusEnum.active,
        type: GarageYardType.yard,
        location: LocationModel.fromJson({
          "id": 6,
          "latitude": 27.7200,
          "longitude": 85.3300,
          "sub_locality": "Suite 601",
          "locality": "Kathmandu",
          "sub_admin_area": "Kathmandu District",
          "admin_area": "Bagmati Province",
          "address_line": "987 Swayambhu",
          "zip_code": "44600",
          "apartment_number": "F-601",
          "sub_thoroughfare": "1234",
          "throughfare": "Swayambhu Rd",
        }),
        condition: CarCondition.fromJson({"id": 6, "name": "Good"}),
        attachments: [
          AttachmentModel(
            id: 10,
            file:
                "https://images.unsplash.com/photo-1549317336-206569e8475c?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1549317336-206569e8475c?w=400",
            name: "nissan_altima_1.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
          AttachmentModel(
            id: 11,
            file:
                "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800",
            thumbnail:
                "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400",
            name: "nissan_altima_2.jpg",
            isInclude: true,
            mime: "image/jpeg",
          ),
        ],
        isNew: false,
        warranty: true,
        miles: 55000.0,
        model: "Altima",
        brand: "Nissan",
        year: "2019",
        phoneNumber: "+977-9846789012",
        availableTimeSlots: [
          AvailableTimeSlot.fromJson({
            "id": 9,
            "date":
                DateTime.now().add(const Duration(days: 9)).toIso8601String(),
            "start_time": "9:00 AM",
            "end_time": "5:00 PM",
            "is_editable": true,
            "garage_yard_id": 6,
          }),
        ],
      ),
    ];
  }

  static PaginatedResponse getDummyPaginatedResponse({
    required int page,
    required int perPage,
    String? searchQuery,
  }) {
    List<Garageayard> allData = getDummyGarageYardList();

    // Apply search filter if provided
    if (searchQuery != null && searchQuery.isNotEmpty) {
      allData =
          allData.where((item) {
            final query = searchQuery.toLowerCase();
            return (item.title?.toLowerCase().contains(query) ?? false) ||
                (item.brand?.toLowerCase().contains(query) ?? false) ||
                (item.model?.toLowerCase().contains(query) ?? false) ||
                (item.description?.toLowerCase().contains(query) ?? false);
          }).toList();
    }

    final total = allData.length;
    final totalPages = (total / perPage).ceil();
    final startIndex = (page - 1) * perPage;
    final endIndex = (startIndex + perPage).clamp(0, total);

    final paginatedData = allData.sublist(startIndex, endIndex);

    return PaginatedResponse(
      status: 200,
      message: "Success",
      pagination: Pagination(
        links: Links(
          next: page < totalPages ? page + 1 : null,
          previous: page > 1 ? page - 1 : null,
        ),
        currentPage: page,
        total: total,
        perPage: perPage,
        totalPages: totalPages,
      ),
      data: paginatedData.map((item) => item.toJson()).toList(),
    );
  }

  static Garageayard? getDummyGarageYardById(int id) {
    try {
      return getDummyGarageYardList().firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}
