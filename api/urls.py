from django.conf.urls import url
from django.urls import include, path
from rest_framework import routers

from .views import (
    LoginProviderViewSet,
    RentViewSet,
    UserDetailsView,
    updatebikelocation,
)

router = routers.DefaultRouter(trailing_slash=False)
router.register(r"rent", RentViewSet, basename="rent")

urlpatterns = [
    url(r"^", include(router.urls)),
    path("bike/updatelocation", updatebikelocation),
    path("user", UserDetailsView.as_view()),
    path("config/loginproviders", LoginProviderViewSet.as_view({"get": "list"})),
]
